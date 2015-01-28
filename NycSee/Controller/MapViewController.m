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

// label to measure selected annotation distance from user
@property (strong, nonatomic) UILabel *selectedAnnotationLabel;

// nearest annotation to user
@property (strong, nonatomic) Annotation *nearest;

// place annotations in mutable array
@property (strong, nonatomic) NSMutableArray *annotationGroup;

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
    
    [self locationManagerCreation];
    
    [self mapViewCreation];
    
    [self buttonCreation];
    
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

- (void) buttonCreation
{
    CGRect findMeFrame = CGRectMake(40, 470, 100, 40);
    CGRect nearestStationFrame = CGRectMake(150, 470, 150, 40);
//    CGRect selectedAnnotationFrame = CGRectMake(170, 430, 150, 40);
    
    self.findMeButton = [[UIButton alloc] initWithFrame:findMeFrame];
    [self.findMeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.findMeButton setTitle:@"Find Me" forState:UIControlStateNormal];
    [self.findMeButton setTitle:@"Searching" forState:UIControlStateHighlighted];
//    [self.findMeButton addTarget:self action:@selector(findMeButtonIsPressed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.findMeButton];
    
//    self.nearestStationButton = [[UIButton alloc] initWithFrame:nearestStationFrame];
//    [self.nearestStationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.nearestStationButton setTitle:@"Nearest Station" forState:UIControlStateNormal];
//    [self.nearestStationButton setTitle:@"Searching" forState:UIControlStateHighlighted];
//    [self.nearestStationButton addTarget:self action:@selector(findNearestIsPressed:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:self.nearestStationButton];
    
    self.selectedAnnotationLabel = [[UILabel alloc] initWithFrame:nearestStationFrame];
    [self.view addSubview:self.selectedAnnotationLabel];
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
            [self.mapView addAnnotations:self.annotationGroup];
        }];
    }];
}

#pragma mark -- mapView methods

- (void) mapViewCreation
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // place boolean didSetRegion here (?)
    if (!self.didSetRegion) {
        CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250.0, 250.0);
        
        [self.mapView setRegion:region animated:NO];
        self.didSetRegion = YES;
    }
    if (self.mapView.selectedAnnotations.count == 0) {
        // no annotation selected
        [self updateDistanceToAnnotation:nil];
    }
    else {
        // first object in array is currently selected annotation
        [self updateDistanceToAnnotation:[self.mapView.selectedAnnotations objectAtIndex:0]];
    }
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
    } else {
        [view setAnnotationData:annotation];
    }
    
    return view;
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [self updateDistanceToAnnotation:view.annotation];
}

//- (void) findMeButtonIsPressed:(UIButton *)sender
//{
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
//}

#pragma mark -- Location -> Annotation math methods

- (void) updateDistanceToAnnotation:(id<MKAnnotation>)annotation
{
    if (!annotation) {
        NSLog(@"No annotation selected");
        return;
    }
    if (!self.mapView.userLocation.location) {
        NSLog(@"User location is unknown");
        return;
    }
    
    CLLocation *pinLocation = [[CLLocation alloc]
                               initWithLatitude:annotation.coordinate.latitude
                               longitude:annotation.coordinate.longitude];
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:self.mapView.userLocation.coordinate.latitude
                                longitude:self.mapView.userLocation.coordinate.longitude];
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    NSString *distanceString = [NSString stringWithFormat:@"%4.0f m away", distance];
    self.selectedAnnotationLabel.text = distanceString;
    NSLog(@"Distance to user: %4.0f m", distance);
}

//- (void) findNearestIsPressed:(UIButton *)sender
//{
////    if (self.nearest) {
////        self.nearest = nil;
////    }
//    self.nearest = nil;
//    self.nearest = [self.annotationGroup firstObject];
//    
//    for (Annotation *ann in self.annotationGroup) {
//        if (ann.distance < self.nearest.distance) {
//            self.nearest = ann;
//        }
//    }
//    
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.nearest.coordinate.latitude, self.nearest.coordinate.longitude);
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 250, 250);
//    
//    [self.mapView setRegion:region animated:YES];
//    [self.mapView selectAnnotation:(id<MKAnnotation>)self.nearest animated:YES];    // is this safe?
//}

#pragma mark -- CoreLocationLocationManager methods

- (void) locationManagerCreation
{
    // iOS 8 necessary methods
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.location = locations.lastObject;
    
    Annotation *annotation; // create object
    
    // search for nearest stations
    for (annotation in self.mapView.annotations) {
        // check that the annotation is not the user location
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            CLLocationCoordinate2D coord = [annotation coordinate];
            CLLocation *anotLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
            CLLocation *newLocation = [locations lastObject];
            annotation.distance = [newLocation distanceFromLocation:anotLocation];
        }
    }
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

@end
