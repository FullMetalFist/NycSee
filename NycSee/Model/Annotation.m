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

// global var
#import "Global.h"

@implementation Annotation

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)coord
                               title:(NSString *)title
                            subtitle:(NSString *)subtitle
                            exitType:(NSString *)exitType
{
    self = [super init];
    if (self) {
        _coordinate = coord;
        _title = title;
        _subtitle = subtitle;
        _exitType = exitType;
    }
    return self;
}

@end
