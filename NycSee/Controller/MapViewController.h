//
//  MapViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/24/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Annotation.h"

@interface MapViewController : UIViewController

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
