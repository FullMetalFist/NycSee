//
//  Annotation.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface Annotation : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)coord
                               title:(NSString *)title
                            subtitle:(NSString *)subtitle;

@end
