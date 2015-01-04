//
//  MapViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/24/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "MapViewController.h"

#import "JSONParser.h"
#import "StationData.h"

#import "AnnotationView.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

// locationManager property moved to .h file
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocation *location;

// prevent snapping to user location
@property (nonatomic) BOOL didSetRegion;

// zoom to user location button & nearest station button
@property (strong, nonatomic) UIButton *findMeButton;
@property (strong, nonatomic) UIButton *nearestStationButton;

// place annotations in custom array for refresh purposes
@property (strong, nonatomic) NSMutableArray *annotationGroup;
@property (strong, nonatomic) NSMutableArray *annotationParsed;

// razor-thin views to hold button in place
@property (strong, nonatomic) UIView *leftSideView;
@property (strong, nonatomic) UIView *rightSideView;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Map";
        self.tabBarItem.image = [UIImage imageNamed:@"Map"];
    }
    return self;
}

#pragma mark -- viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // iOS 8 necessary methods
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }    
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    //self.mapView.showsUserLocation = YES; // moved to locationManager:didChangeAuthorizationStatus method
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    

    
    self.findMeButton = [[UIButton alloc] init];
    [self.findMeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.findMeButton setTitle:@"Find Me" forState:UIControlStateNormal];
    [self.findMeButton setTitle:@"Searching" forState:UIControlStateHighlighted];
    [self.findMeButton addTarget:self action:@selector(findMeButtonIsPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.findMeButton];
    
    //TODO: nearestStation search method
    self.nearestStationButton = [[UIButton alloc] init];
    [self.nearestStationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.nearestStationButton setTitle:@"Nearest Station" forState:UIControlStateNormal];
    [self.nearestStationButton setTitle:@"Searching" forState:UIControlStateHighlighted];
    [self.nearestStationButton addTarget:self action:@selector(nearestStationButtonIsPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.nearestStationButton];
    
    //TODO: fix autolayout constraints (app breaks constraints at runtime)
    self.findMeButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_findMeButton, _nearestStationButton);
    NSDictionary *metrics = @{@"findMeButtonWidth":@80,@"nearestStationButtonWidth":@100,@"buttonHeight":@40};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[_findMeButton(findMeButtonWidth)][_nearestStationButton(nearestStationButtonWidth)]-60-|" options:0 metrics: metrics views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_findMeButton(buttonHeight)]-50-|" options:0 metrics: metrics views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nearestStationButton(buttonHeight)]-50-|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self consolidateData];
}

- (void)viewWillAppear:(BOOL)animated
{
    // when view appears after loading...
    [self.locationManager startUpdatingLocation];
    /* following method within viewWillAppear proved counter-productive */
//    [self consolidateData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

#pragma mark -- JSON Parsing method

- (void)consolidateData
{
    NSArray *allTheData = [JSONParser locations];
    self.annotationGroup = [NSMutableArray array];
    
    // GCD (dispatch_async) should be implemented
    // less overhead but can't be cancelled.
    NSOperationQueue *aQueue = [[NSOperationQueue alloc] init];
    
    [aQueue addOperationWithBlock:^{
        for (NSDictionary *exitData in allTheData) {
            StationData *singleStation = [[StationData alloc] initWithStationName:exitData[@"Station_Name"]
                            route01:exitData[@"Route_1"]
                            route02:exitData[@"Route_2"]
                            route03:exitData[@"Route_3"]
                            route04:exitData[@"Route_4"]
                            route05:exitData[@"Route_5"]
                            route06:exitData[@"Route_6"]
                            route07:exitData[@"Route_7"]
                            route08:exitData[@"Route_8"]
                            route09:exitData[@"Route_9"]
                            route10:exitData[@"Route_10"]
                            route11:exitData[@"Route_11"]
                       entranceType:exitData[@"Entrance_Type"]
                           latitude:[exitData[@"Latitude"] doubleValue]
                          longitude:[exitData[@"Longitude"] doubleValue]];
            // record lat-lng for line overlay
            // separate route and display overlay on the map
            Annotation *annotation = [[Annotation alloc] initWithCoordinates:singleStation.coordinate
                                                                       title:singleStation.stationName
                                                                    subtitle:[NSString stringWithFormat:@"%@ %@",singleStation.trains, singleStation.entranceType]
                                                                    exitType:singleStation.entranceType];
            [self.annotationGroup addObject:annotation];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [self.mapView addAnnotations:self.annotationGroup];
            [self annotationConversion];
            [self.mapView addAnnotations:self.annotationParsed];
        }];
    }];
}

- (void) annotationConversion {
    //create parsed array object
    self.annotationParsed = [NSMutableArray array];
    //create loop
    for (Annotation *annotationChk in self.annotationGroup) {
        // create new annotation object for each of the five types
        
        if ([annotationChk.exitType isEqualToString:@"Elevator"]) {
            Annotation *annotationElevator = annotationChk;
            
            [self.annotationParsed addObject:annotationElevator];
        } else if ([annotationChk.exitType isEqualToString:@"Escalator"]) {
            Annotation *annotationEscalator = annotationChk;
            [self.annotationParsed addObject:annotationEscalator];
        } else if ([annotationChk.exitType isEqualToString:@"Door"]) {
            Annotation *annotationDoor = annotationChk;
            [self.annotationParsed addObject:annotationDoor];
        } else if ([annotationChk.exitType isEqualToString:@"Easement"]) {
            Annotation *annotationEasement = annotationChk;
            [self.annotationParsed addObject:annotationEasement];
        } else if ([annotationChk.exitType isEqualToString:@"Stair"]){
            Annotation *annotationStair = annotationChk;
            [self.annotationParsed addObject:annotationStair];
        }
    }
    // set entrancetype
}

#pragma mark -- mapView methods

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // place boolean didSetRegion here (?)
    if (!self.didSetRegion) {
        CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500.0, 500.0);
        
        [self.mapView setRegion:region animated:NO];
        self.didSetRegion = YES;
    }
    
    /* below commands are excess */
//    CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500.0, 500.0);
//    
//    [self.mapView setRegion:region animated:NO];
//    [self consolidateData];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"pin";
    
    AnnotationView *view = (AnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (view == nil) {
        view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    return view;
}

- (void) updateMapViewAnnotations
{
    // props iTunesU Hegarty
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.annotationGroup];
}

/*
 MKOverlayRenderer
 */

#pragma mark -- CoreLocationLocationManager methods

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.location = locations.lastObject;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) findMeButtonIsPressed:(UIButton *)sender {
//    CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500.0, 500.0);
//    [self.mapView setRegion:region animated:YES];
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    [self updateMapViewAnnotations];
}

- (void) nearestStationButtonIsPressed:(UIButton *)sender
{
    //TODO: nearestStation search method
    NSLog(@"Find nearest station");
}

@end
