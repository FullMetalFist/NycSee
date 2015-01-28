//
//  ServiceViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/20/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController

#pragma mark -- Visual Format Language Constants

NSString *const kNameLabelHorizontal = @"H:|-[_nameLabel]-|";
NSString *const kNameLabelVertical = @"V:|-[_nameLabel]-|";
NSString *const kStatusLabelHorizontal = @"H:|-[_statusLabel]-|";
NSString *const kStatusLabelVertical = @"V:|-[_statusLabel]-|";
NSString *const kTextLabelHorizontal = @"H:|-[_textLabel]-|";
NSString *const kTextLabelVertical = @"V:|-[_textLabel]|";
NSString *const kDateLabelHorizontal = @"H:|-[_dateLabel]-|";
NSString *const kDateLabelVertical = @"V:|-[_dateLabel]|";
NSString *const kTimeLabelHorizontal = @"H:|-[_timeLabel]-|";
NSString *const kTimeLabelVertical = @"V:|-[_timeLabel]|";

double const kXCoordinateServicePage = 20.0f;
double const kFrameWidthServicePage = 280.0f;
double const kFrameHeightLesserServicePage = 20.0f;
double const kFrameHeightGreaterServicePage = 40.0f;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Service Changes";
        self.tabBarItem.image = [UIImage imageNamed:@"wrench"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Service Changes";
    CGRect nameLabelFrame = CGRectMake(kXCoordinateServicePage, 70.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
    CGRect statusLabelFrame = CGRectMake(kXCoordinateServicePage, 100.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
    CGRect textLabelFrame = CGRectMake(kXCoordinateServicePage, 130.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
    CGRect dateLabelFrame = CGRectMake(kXCoordinateServicePage, 200.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
    CGRect timeLabelFrame = CGRectMake(kXCoordinateServicePage, 230.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
    
    self.nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
    self.statusLabel = [[UILabel alloc] initWithFrame:statusLabelFrame];
    self.textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
    self.dateLabel = [[UILabel alloc] initWithFrame:dateLabelFrame];
    self.timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
    
    self.nameLabel.text = self.xmlServiceData.name;
    self.statusLabel.text = self.xmlServiceData.status;
    self.textLabel.text = self.xmlServiceData.text;
    self.dateLabel.text = self.xmlServiceData.date;
    self.timeLabel.text = self.xmlServiceData.time;
    
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 3;
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.timeLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
