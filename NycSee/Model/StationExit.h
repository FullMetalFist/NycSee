//
//  StationExit.h
//  NycSee
//
//  Created by Michael Vilabrera on 1/9/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StationExit : NSObject

@property (strong, nonatomic) MKMapItem *mapItem;

- (instancetype) initWithMapItem:(MKMapItem *) mapItem;
- (CLLocationDistance) distanceFromLocation:(CLLocation *) location;

@end
