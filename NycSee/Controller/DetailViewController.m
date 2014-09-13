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
@property (nonatomic, strong) UIView *innerView;

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

double const kXCoordinate = 20.0f;
double const kFrameWidth = 280.0f;
double const kFrameHeightLesser = 20.0f;
double const kFrameHeightGreater = 40.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Outage Detail";
        self.tabBarItem.image = [UIImage imageNamed:@"Outages"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect innerViewFrame = CGRectMake(10.0f, 10.0f, 240, 400000);
    NSDictionary *viewsDictionary;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.innerView = [[UIView alloc] initWithFrame:innerViewFrame];
    self.scrollView.delegate = self;
    
    CGRect stationLabelFrame = CGRectMake(kXCoordinate, 10.0f, kFrameWidth, kFrameHeightGreater);
    CGRect boroughLabelFrame = CGRectMake(kXCoordinate, 40.0f, kFrameWidth, kFrameHeightLesser);
    CGRect trainLabelFrame = CGRectMake(kXCoordinate, 70.0f, kFrameWidth, kFrameHeightLesser);
    CGRect typeLabelFrame = CGRectMake(kXCoordinate, 100.0f, kFrameWidth, kFrameHeightLesser);
    CGRect servingLabelFrame = CGRectMake(kXCoordinate, 120.0f, kFrameWidth, kFrameHeightGreater);
    CGRect outageDateLabelFrame = CGRectMake(kXCoordinate, 150.0f, kFrameWidth, kFrameHeightLesser);
    CGRect expectedReturnToServiceLabelFrame = CGRectMake(kXCoordinate, 180.0f, kFrameWidth, kFrameHeightLesser);
    
    self.stationLabel = [[UILabel alloc] initWithFrame:stationLabelFrame];
    self.boroughLabel = [[UILabel alloc] initWithFrame:boroughLabelFrame];
    self.trainLabel = [[UILabel alloc] initWithFrame:trainLabelFrame];
    self.typeLabel = [[UILabel alloc] initWithFrame:typeLabelFrame];
    self.servingLabel = [[UILabel alloc] initWithFrame:servingLabelFrame];
    self.outageDateLabel = [[UILabel alloc] initWithFrame:outageDateLabelFrame];
    self.expectedReturnToServiceLabel = [[UILabel alloc] initWithFrame:expectedReturnToServiceLabelFrame];
    
    self.stationLabel.text = self.xmlData.station;
    self.boroughLabel.text = self.xmlData.borough;
    self.trainLabel.text = self.xmlData.trainno;
    self.typeLabel.text = self.xmlData.equipment;
    self.servingLabel.text = self.xmlData.serving;
    self.outageDateLabel.text = self.xmlData.outageDate;
    self.expectedReturnToServiceLabel.text = self.xmlData.estimatedReturnToService;
    
    self.innerView.center = self.scrollView.center;
    self.stationLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.stationLabel.numberOfLines = 0;
    self.servingLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.servingLabel.numberOfLines = 0;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.innerView];
    [self.innerView addSubview:self.stationLabel];
    [self.innerView addSubview:self.boroughLabel];
    [self.innerView addSubview:self.trainLabel];
    [self.innerView addSubview:self.typeLabel];
    [self.innerView addSubview:self.servingLabel];
    [self.innerView addSubview:self.outageDateLabel];
    [self.innerView addSubview:self.expectedReturnToServiceLabel];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.innerView.translatesAutoresizingMaskIntoConstraints = NO;
    viewsDictionary = NSDictionaryOfVariableBindings(_scrollView, _innerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_innerView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_innerView]|" options:0 metrics: 0 views:viewsDictionary]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
