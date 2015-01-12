//
//  StationExit.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/9/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "StationExit.h"

@implementation StationExit

- (instancetype) initWithMapItem:(MKMapItem *)mapItem
{
    self = [super init];
    self.mapItem = mapItem;
    return self;
}

- (CLLocationDistance) distanceFromLocation:(CLLocation *)location
{
    return [self.mapItem.placemark.location distanceFromLocation:location];
}

@end
