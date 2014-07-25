//
//  StationData.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface StationData : NSObject

@property (strong, nonatomic) NSString *division;
@property (strong, nonatomic) NSString *line;
@property (strong, nonatomic) NSString *stationName;
@property (strong, nonatomic) NSString *trains;

@property (strong, nonatomic) NSString *route01;
@property (strong, nonatomic) NSString *route02;
@property (strong, nonatomic) NSString *route03;
@property (strong, nonatomic) NSString *route04;
@property (strong, nonatomic) NSString *route05;
@property (strong, nonatomic) NSString *route06;
@property (strong, nonatomic) NSString *route07;
@property (strong, nonatomic) NSString *route08;
@property (strong, nonatomic) NSString *route09;
@property (strong, nonatomic) NSString *route10;
@property (strong, nonatomic) NSString *route11;

@property (strong, nonatomic) NSString *entranceType;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype) initWithStationName:(NSString *)stationName
                             route01:(NSString *)route01
                             route02:(NSString *)route02
                             route03:(NSString *)route03
                             route04:(NSString *)route04
                             route05:(NSString *)route05
                             route06:(NSString *)route06
                             route07:(NSString *)route07
                             route08:(NSString *)route08
                             route09:(NSString *)route09
                             route10:(NSString *)route10
                             route11:(NSString *)route11
                        entranceType:(NSString *)entranceType
                            latitude:(double)latitude
                           longitude:(double)longitude;

@end
