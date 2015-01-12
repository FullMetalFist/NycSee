//
//  MapUtils.h
//  NycSee
//
//  Created by Michael Vilabrera on 1/12/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MapUtils : NSObject

+ (CLLocation *)findNearestLocationForPoint:(CLLocation *)point withPoints:(NSArray *)points;

@end
