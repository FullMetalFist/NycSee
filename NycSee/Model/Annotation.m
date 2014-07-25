//
//  Annotation.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "Annotation.h"

#import "JSONParser.h"
#import "StationData.h"

@implementation Annotation

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)coord
                               title:(NSString *)title
                            subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        _coordinate = coord;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}

@end
