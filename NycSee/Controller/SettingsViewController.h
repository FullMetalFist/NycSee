//
//  SettingsViewController.h
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (nonatomic) BOOL stairsChoice;            // YES indicates they will be shown
@property (nonatomic) BOOL easementChoice;          // NO indicates they will not be shown
@property (nonatomic) BOOL doorChoice;
@property (nonatomic) BOOL elevatorChoice;
@property (nonatomic) BOOL escalatorChoice;

@property (nonatomic) BOOL saveOutageChoice;        // activate CoreData

@end
