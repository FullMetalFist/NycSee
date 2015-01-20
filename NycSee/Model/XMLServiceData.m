//
//  XMLServiceData.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/19/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "XMLServiceData.h"

@implementation XMLServiceData

- (instancetype) init
{
    return [self initWithName:@"" status:@"" text:@"" date:@"" time:@""];
}

- (instancetype) initWithName:(NSString *)name
                       status:(NSString *)status
                         text:(NSString *)text
                         date:(NSString *)date
                         time:(NSString *)time
{
    self = [super init];
    if (self) {
        _name = name;
        _status = status;
        _text = text;
        _date = date;
        _time = time;
    }
    return self;
}

@end
