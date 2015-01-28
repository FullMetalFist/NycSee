//
//  ServiceTableViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 1/19/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServiceViewController.h"

@interface ServiceTableViewController : UITableViewController

@property (nonatomic, strong) ServiceViewController *serviceVC;
@property (nonatomic, strong) NSMutableArray *allDataFromService;

@end
