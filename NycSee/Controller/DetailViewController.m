//
//  DetailViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/25/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DetailViewController

#pragma mark -- Visual Format Language Constants

NSString *const kStationLabelHorizontal = @"H:|-[_stationLabel]-|";
NSString *const kStationLabelVertical = @"V:|-[_stationLabel]|";
NSString *const kBoroughLabelHorizontal = @"H:|-[_boroughLabel]-|";
NSString *const kBoroughLabelVertical = @"V:|[_boroughLabel]-|";
NSString *const kTrainLabelHorizontal = @"H:|-[_trainLabel]-|";
NSString *const kTrainLabelVertical = @"V:|-[_trainLabel]-|";
NSString *const kTypeLabelHorizontal = @"H:|-[_typeLabel]-|";
NSString *const kTypeLabelVertical = @"V:|-[_typeLabel]-|";
NSString *const kServingLabelHorizontal = @"H:|-[_servingLabel]-|";
NSString *const kServingLabelVertical = @"V:|-[_servingLabel]-|";
NSString *const kOutageDateLabelHorizontal = @"H:|-[_outageDateLabel]-|";
NSString *const kOutageDateLabelVertical = @"V:|-[_outageDateLabel]-|";
NSString *const kExpectedReturnToServiceLabelHorizontal = @"H:|-[_expectedReturnToServiceLabel]-|";
NSString *const kExpectedReturnToServiceLabelVertical = @"V:|[_expectedReturnToServiceLabel]-100-|";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Outage Detail";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 960, 640)];
    CGRect stationLabelFrame = CGRectMake(0.0f, 0.0f, 320.0f, 200.0f);
    self.stationLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    CGRect boroughLabelFrame = CGRectMake(300.0f, 200.0f, 300.0f, 200.0f);
    self.boroughLabel = [[UILabel alloc] initWithFrame:boroughLabelFrame];
    self.trainLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    self.typeLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    self.servingLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    self.outageDateLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    self.expectedReturnToServiceLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    
    self.stationLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    self.stationLabel.center = innerView.center;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.stationLabel];
    [self.scrollView addSubview:self.boroughLabel];
    [self.scrollView addSubview:self.trainLabel];
    self.stationLabel.text = self.xmlData.station;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
