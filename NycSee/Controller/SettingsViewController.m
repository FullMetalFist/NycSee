//
//  SettingsViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "SettingsViewController.h"
#import "Annotation.h"

@interface SettingsViewController ()

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
    
    [self drawLabelsWithSwitches];
}

- (void) drawLabelsWithSwitches
{
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
    
    [self.view addSubview:self.stairsLabel];
    [self.view addSubview:self.easementLabel];
    [self.view addSubview:self.doorLabel];
    [self.view addSubview:self.elevatorLabel];
    [self.view addSubview:self.escalatorLabel];
    [self.view addSubview:self.saveOutageLabel];
    
    [self.view addSubview:self.stairsSwitch];
    [self.view addSubview:self.easementSwitch];
    [self.view addSubview:self.doorSwitch];
    [self.view addSubview:self.elevatorSwitch];
    [self.view addSubview:self.escalatorSwitch];
    [self.view addSubview:self.saveOutageSwitch];
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

#pragma mark -- switch methods
- (void) switchStairsIsChanged:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"The switch is turned on");
    }
    else {
        NSLog(@"The switch is turned off");
    }
}

- (void) switchEasementIsChanged:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"The switch is turned on");
    }
    else {
        NSLog(@"The switch is turned off");
    }
}

- (void) switchDoorIsChanged:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"The switch is turned on");
    }
    else {
        NSLog(@"The switch is turned off");
    }
}

- (void) switchElevatorIsChanged:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"The switch is turned on");
    }
    else {
        NSLog(@"The switch is turned off");
    }
}

- (void) switchEscalatorIsChanged:(UISwitch *)sender {
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
