//
//  StationData.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "StationData.h"

@implementation StationData

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
                           longitude:(double)longitude
{
    self = [super init];
    if (self) {
        _stationName = stationName;
        _route01 = route01;
        _route02 = route02;
        _route03 = route03;
        _route04 = route04;
        _route05 = route05;
        _route06 = route06;
        _route07 = route07;
        _route08 = route08;
        _route09 = route09;
        _route10 = route10;
        _route11 = route11;
        _trains = [self allRoutes:route01
                          route02:route02
                          route03:route03
                          route04:route04
                          route05:route05
                          route06:route06
                          route07:route07
                          route08:route08
                          route09:route09
                          route10:route10
                          route11:route11];
        _entranceType = entranceType;
        _latitude = latitude;
        _longitude = longitude;
        _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

- (NSString *)allRoutes:(NSString *)route01
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
{
    NSMutableString *routes = [NSMutableString string];
    [routes appendFormat:@"%@%@%@%@%@%@%@%@%@%@%@",route01,route02,route03,route04,route05,route06,route07,route08,route09,route10,route11];
    return [NSString stringWithFormat:@"%@", routes];;
}

@end
