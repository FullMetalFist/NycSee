//
//  XMLData.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLData : NSObject

@property (strong, nonatomic) NSString *station;
@property (strong, nonatomic) NSString *borough;
@property (strong, nonatomic) NSString *trainno;
@property (strong, nonatomic) NSString *equipment;

@property (strong, nonatomic) NSString *serving;
@property (strong, nonatomic) NSString *outageDate;
@property (strong, nonatomic) NSString *estimatedReturnToService;

- (instancetype) initWithStation:(NSString *)station
                         borough:(NSString *)borough
                         trainno:(NSString *)train
                       equipment:(NSString *)equipment
                         serving:(NSString *)serving
                      outageDate:(NSString *)outageDate
        estimatedReturnToService:(NSString *)estimatedReturnToService;

@end
