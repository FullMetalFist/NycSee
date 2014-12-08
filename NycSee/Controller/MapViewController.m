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
@property (nonatomic) BOOL didSetRegion;
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
    //[self.locationManager requestWhenInUseAuthorization];
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    //self.mapView.showsUserLocation = YES; // moved to locationManager:didChangeAuthorizationStatus method
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    // when view appears after loading...
    [self.locationManager startUpdatingLocation];
    [self consolidateData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)consolidateData
{
    NSArray *allTheData = [JSONParser locations];
    NSMutableArray *annotationGroup = [NSMutableArray array];
    
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
            [annotationGroup addObject:annotation];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.mapView addAnnotations:annotationGroup];
        }];
    }];
}

#pragma mark -- mapView methods

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!self.didSetRegion) {
        CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500.0, 500.0);
        
        [self.mapView setRegion:region animated:NO];
        self.didSetRegion = YES;
    }
//    [self consolidateData];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
//    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
//    if (view == nil) {
//        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
//    }
//    UIImageView *imageView = [[UIImageView alloc] init];
//    view.leftCalloutAccessoryView = imageView;
//    view.enabled = YES;
//    view.canShowCallout = YES;
    
    // set pin types:
    // elevator -   green
    // escalator-   orange
    // door     -   blue
    // easement -   purple
    // stairs   -   red
    static NSString *identifierRed = @"pinRed";
    static NSString *identifierGreen = @"pinGreen";
    static NSString *identifierOrange = @"pinOrange";
    static NSString *identifierBlue = @"pinBlue";
    static NSString *identifierPurple = @"pinPurple";
    
    AnnotationView *view = (AnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifierRed];
    if (view == nil) {
        if (view.color == [UIColor redColor]) {
            view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierRed];
        }
        else if (view.color == [UIColor greenColor]) {
            view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierGreen];
        }
        else if (view.color == [UIColor orangeColor]) {
            view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierOrange];
        }
        else if (view.color == [UIColor blueColor]) {
            view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierBlue];
        }
        else {
            view = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierPurple];
        }
    }
    
    return view;
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

@end
