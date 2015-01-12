//
//  MapUtils.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/12/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "MapUtils.h"

@implementation MapUtils

// thanks #github gongliang
+ (CLLocation *)findNearestLocationForPoint:(CLLocation *)point withPoints:(NSArray *)points
{
    NSArray *sorted = [points sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        CLLocationDistance d1 = [point distanceFromLocation:a];
        CLLocationDistance d2 = [point distanceFromLocation:b];
        if (d1 < d2) {
            return NSOrderedAscending;
        } else if (d1 > d2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return sorted[0];
}

@end
