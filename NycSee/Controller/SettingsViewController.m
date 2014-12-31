//
//  SettingsViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *innerView;

@property (strong, nonatomic) UILabel *stairsLabel;
@property (strong, nonatomic) UILabel *easementLabel;
@property (strong, nonatomic) UILabel *doorLabel;
@property (strong, nonatomic) UILabel *elevatorLabel;
@property (strong, nonatomic) UILabel *escalatorLabel;

@property (strong, nonatomic) UILabel *saveOutageLabel;

@property (strong, nonatomic) UISwitch *stairsSwitch;
@property (strong, nonatomic) UISwitch *easementSwitch;
@property (strong, nonatomic) UISwitch *doorSwitch;
@property (strong, nonatomic) UISwitch *elevatorSwitch;
@property (strong, nonatomic) UISwitch *escalatorSwitch;

@property (strong, nonatomic) UISwitch *saveOutageSwitch;

@end

@implementation SettingsViewController

#pragma mark -- Visual Format Language Constants

//NSString *const kStationLabelHorizontal = @"H:|-[_stairsLabel]-|";
//NSString *const kStationLabelVertical = @"V:|-[_stairsLabel]|";

//double const kXCoordinate = 20.0f;
//double const kFrameWidth = 280.0f;
//double const kFrameHeightLesser = 20.0f;
//double const kFrameHeightGreater = 40.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
        self.tabBarItem.image = [UIImage imageNamed:@"Settings"];
    }
    return self;
}

//TODO: set UIViews to their place in this view controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
