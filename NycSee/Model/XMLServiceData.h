//
//  XMLServiceData.h
//  NycSee
//
//  Created by Michael Vilabrera on 1/19/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLServiceData : NSObject

/*
 <line>
 <name>123</name>
 <status>GOOD SERVICE</status>
 <text />
 <Date></Date>
 <Time></Time>
 </line>
 */

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *time;

- (instancetype) initWithName:(NSString *)name
                       status:(NSString *)status
                         text:(NSString *)text
                         date:(NSString *)date
                         time:(NSString *)time;

@end
