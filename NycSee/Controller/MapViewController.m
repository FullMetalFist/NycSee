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

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

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
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    [self consolidateData];
}

- (void)consolidateData
{
    NSArray *allTheData = [JSONParser locations];
    NSMutableArray *annotationGroup = [NSMutableArray array];
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
        Annotation *annotation = [[Annotation alloc] initWithCoordinates:singleStation.coordinate
                                                                   title:singleStation.stationName
                                                                subtitle:[NSString stringWithFormat:@"%@ %@",singleStation.trains, singleStation.entranceType]
                                                                exitType:singleStation.entranceType];
        [annotationGroup addObject:annotation];
    }
    [self.mapView addAnnotations:annotationGroup];
}

#pragma mark -- mapView methods

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1000.0, 1000.0);
    
    [self.mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (view == nil) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    view.leftCalloutAccessoryView = imageView;
    view.enabled = YES;
    view.canShowCallout = YES;
    return view;
}

#pragma mark -- CoreLocationLocationManager methods

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
