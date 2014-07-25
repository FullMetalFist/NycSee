//
//  DetailViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMLData.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) XMLData *xmlData;
@property (strong, nonatomic) UILabel *stationLabel;
@property (strong, nonatomic) UILabel *boroughLabel;
@property (strong, nonatomic) UILabel *trainLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *servingLabel;
@property (strong, nonatomic) UILabel *outageDateLabel;
@property (strong, nonatomic) UILabel *expectedReturnToServiceLabel;

@end
