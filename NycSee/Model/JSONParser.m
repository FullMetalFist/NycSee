//
//  JSONParser.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

+ (NSArray *) locations
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"subway" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *locations = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return locations;
}

@end
