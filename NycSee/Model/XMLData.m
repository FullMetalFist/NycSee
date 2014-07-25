//
//  XMLData.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "XMLData.h"

@implementation XMLData

- (instancetype) init
{
    return [self initWithStation:@""
                         borough:@""
                         trainno:@""
                       equipment:@""
                         serving:@""
                      outageDate:@""
        estimatedReturnToService:@""];
}

- (instancetype) initWithStation:(NSString *)station
                         borough:(NSString *)borough
                         trainno:(NSString *)train
                       equipment:(NSString *)equipment
                         serving:(NSString *)serving
                      outageDate:(NSString *)outageDate
        estimatedReturnToService:(NSString *)estimatedReturnToService
{
    self = [super init];
    if (self) {
        _station = station;
        _borough = borough;
        _trainno = train;
        _equipment = equipment;
        _serving = serving;
        _outageDate = outageDate;
        _estimatedReturnToService = estimatedReturnToService;
    }
    return self;
}

@end
