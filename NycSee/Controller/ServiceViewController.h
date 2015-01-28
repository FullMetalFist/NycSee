//
//  ServiceViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 1/20/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMLServiceData.h"

@interface ServiceViewController : UIViewController

@property (strong, nonatomic) XMLServiceData *xmlServiceData;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end
