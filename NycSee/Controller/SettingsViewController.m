//
//  SettingsViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UIScrollViewDelegate>

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

NSString *const kStairsLabelHorizontal = @"H:|-[_stairsLabel]-|";
NSString *const kStairsLabelVertical = @"V:|-[_stairsLabel]|";
NSString *const kEasementLabelHorizontal = @"H:|-[_easementLabel]-|";
NSString *const kEasementLabelVertical = @"V:|-[_easementLabel]|";
NSString *const kDoorLabelHorizontal = @"H:|-[_doorLabel]-|";
NSString *const kDoorLabelVertical = @"V:|-[_doorLabel]|";
NSString *const kElevatorLabelHorizontal = @"H:|-[_elevatorLabel]-|";
NSString *const kElevatorLabelVertical = @"V:|-[_elevatorLabel]|";
NSString *const kEscalatorLabelHorizontal = @"H:|-[_escalatorLabel]-|";
NSString *const kEscalatorLabelVertical = @"V:|-[_escalatorLabel]|";
NSString *const kSaveOutageLabelHorizontal = @"H:|-[_saveOutageLabel]-|";
NSString *const kSaveOutageLabelVertical = @"V:|-[_saveOutageLabel]-100-|";

NSString *const kStairsSwitchHorizontal = @"H:|-[_stairsSwitch]|";
NSString *const kStairsSwitchVertical = @"V:|-[_stairsSwitch]|";
NSString *const kEasementSwitchHorizontal = @"H:|-[_easementSwitch]-|";
NSString *const kEasementSwitchVertical = @"V:|-[_easementSwitch]-|";
NSString *const kDoorSwitchHorizontal = @"H:|-[_doorSwitch]-|";
NSString *const kDoorSwitchVertical = @"V:|-[_doorSwitch]-|";
NSString *const kElevatorSwitchHorizontal = @"H:|-[_elevatorSwitch]-|";
NSString *const kElevatorSwitchVertical = @"V:|-[_elevatorSwitch]-|";
NSString *const kEscalatorSwitchHorizontal = @"H:|-[_escalatorSwitch]-|";
NSString *const kEscalatorSwitchVertical = @"V:|-[_escalatorSwitch]-|";
NSString *const kSaveOutageSwitchHorizontal = @"H:|-[_saveOutageSwitch]-|";
NSString *const kSaveOutageSwitchVertical = @"V:|-[_saveOutageSwitch]-100-|";


double const kXCoordinateLabelSettingsPage = 20.0f;
double const kXCoordinateSwitchSettingsPage = 220.0f;
double const kFrameWidthSettingsPage = 280.0f;
double const kFrameHeightLesserSettingsPage = 20.0f;
double const kFrameHeightGreaterSettingsPage = 40.0f;

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
    CGRect innerViewFrame = CGRectMake(10.0f, 10.0f, 240, 400000);
    NSDictionary *viewsDictionary;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.innerView = [[UIView alloc] initWithFrame:innerViewFrame];
    self.scrollView.delegate = self;
    
    CGRect stairsLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 70.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect easementLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 110.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect doorLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 150.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect elevatorLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 190.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect escalatorLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 230.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect saveOutageLabelFrame = CGRectMake(kXCoordinateLabelSettingsPage, 270.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    
    CGRect stairsSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 60.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect easementSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 100.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect doorSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 140.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect elevatorSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 180.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect escalatorSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 220.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    CGRect saveOutageSwitchFrame = CGRectMake(kXCoordinateSwitchSettingsPage, 260.0f, kFrameWidthSettingsPage, kFrameHeightLesserSettingsPage);
    
    self.stairsLabel = [[UILabel alloc] initWithFrame:stairsLabelFrame];
    self.easementLabel = [[UILabel alloc] initWithFrame:easementLabelFrame];
    self.doorLabel = [[UILabel alloc] initWithFrame:doorLabelFrame];
    self.elevatorLabel = [[UILabel alloc] initWithFrame:elevatorLabelFrame];
    self.escalatorLabel = [[UILabel alloc] initWithFrame:escalatorLabelFrame];
    self.saveOutageLabel = [[UILabel alloc] initWithFrame:saveOutageLabelFrame];
    
    self.stairsSwitch = [[UISwitch alloc] initWithFrame:stairsSwitchFrame];
    self.easementSwitch = [[UISwitch alloc] initWithFrame:easementSwitchFrame];
    self.doorSwitch = [[UISwitch alloc] initWithFrame:doorSwitchFrame];
    self.elevatorSwitch = [[UISwitch alloc] initWithFrame:elevatorSwitchFrame];
    self.escalatorSwitch = [[UISwitch alloc] initWithFrame:escalatorSwitchFrame];
    self.saveOutageSwitch = [[UISwitch alloc] initWithFrame:saveOutageSwitchFrame];
    [self.stairsSwitch isEnabled];
    [self.easementSwitch isEnabled];
    [self.doorSwitch isEnabled];
    [self.elevatorSwitch isEnabled];
    [self.escalatorSwitch isEnabled];
    [self.saveOutageSwitch isEnabled];
    
    self.stairsLabel.text = @"Stairs Visible";
    self.easementLabel.text = @"Easement Visible";
    self.doorLabel.text = @"Door Visible";
    self.elevatorLabel.text = @"Elevator Visible";
    self.escalatorLabel.text = @"Escalator Visible";
    self.saveOutageLabel.text = @"Save Outages to Phone";
    
    //TODO: will need to reduce these calls, if possible
    [self.stairsSwitch addTarget:self
                          action:@selector(switchIsChanged:)
                forControlEvents:UIControlEventValueChanged];
    [self.easementSwitch addTarget:self
                            action:@selector(switchIsChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self.doorSwitch addTarget:self
                        action:@selector(switchIsChanged:)
              forControlEvents:UIControlEventValueChanged];
    [self.elevatorSwitch addTarget:self
                            action:@selector(switchIsChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self.escalatorSwitch addTarget:self
                             action:@selector(switchIsChanged:)
                   forControlEvents:UIControlEventValueChanged];
    [self.saveOutageSwitch addTarget:self
                              action:@selector(switchIsChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    //TODO: will need to figure a way to save user setting
    [self.stairsSwitch setOn:YES animated:YES];
    [self.easementSwitch setOn:YES animated:YES];
    [self.doorSwitch setOn:YES animated:YES];
    [self.elevatorSwitch setOn:YES animated:YES];
    [self.escalatorSwitch setOn:YES animated:YES];
    [self.saveOutageSwitch setOn:YES animated:YES];
    
    self.innerView.center = self.scrollView.center;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.innerView];
    [self.innerView addSubview:self.stairsLabel];
    [self.innerView addSubview:self.easementLabel];
    [self.innerView addSubview:self.doorLabel];
    [self.innerView addSubview:self.elevatorLabel];
    [self.innerView addSubview:self.escalatorLabel];
    [self.innerView addSubview:self.saveOutageLabel];
    
    [self.innerView addSubview:self.stairsSwitch];
    [self.innerView addSubview:self.easementSwitch];
    [self.innerView addSubview:self.doorSwitch];
    [self.innerView addSubview:self.elevatorSwitch];
    [self.innerView addSubview:self.escalatorSwitch];
    [self.innerView addSubview:self.saveOutageSwitch];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.innerView.translatesAutoresizingMaskIntoConstraints = NO;
    viewsDictionary = NSDictionaryOfVariableBindings(_scrollView, _innerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_innerView]|" options:0 metrics:0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_innerView]|" options:0 metrics:0 views:viewsDictionary]];
}

//TODO: would be nice if one function could handle all switches
- (void) switchIsChanged:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"The switch is turned on");
    }
    else {
        NSLog(@"The switch is turned off");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
