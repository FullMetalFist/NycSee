//
//  XMLTableViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/24/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailViewController.h"

@interface XMLTableViewController : UITableViewController

@property (nonatomic, strong) DetailViewController *detailVC;
@property (nonatomic, strong) NSMutableArray *allDataFromXML;

@end
