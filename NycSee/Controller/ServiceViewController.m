//
//  ServiceViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/20/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "ServiceViewController.h"
#import "Constant.h"

@interface ServiceViewController () <NSXMLParserDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSURL *url;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.textView.editable = NO;
    
    self.url = [[NSURL alloc] initWithString:SERVICE_STATUS_URL];
    NSError *error = [[NSError alloc] init];
    NSData *data = [[NSData alloc] initWithContentsOfURL:self.url options:NSUTF8StringEncoding error:&error];
    data = [self replaceHTMLentities:data];
    
    [self.view addSubview:self.textView];
}

- (NSData *) replaceHTMLentities:(NSData *)data
{
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *temp = [NSMutableString stringWithString:htmlCode];
    
    NSString *modifiedTemp = [NSString string];
    modifiedTemp = [temp stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    NSLog(@"%@", modifiedTemp);     // gives desired output
    
    // lets take this a bit further and remove <STRONG>,</STRONG>,<br/>,<P>,</P> tags.
    // also remove partial tags <span class=",">,</span>
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<STRONG>" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"</STRONG>" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"Â" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<text />" withString:@"<br/><br/>"];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"Show Reroute Details" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<P>" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"</P>" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<span class=\"" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"\">" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    // finally, remove dead weight 'Title', 'Date', TitleServiceChange" >
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"TitleDelay" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"DateStyle" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"TitleServiceChange\" >" withString:@""];
    //    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"TitlePlannedWork\" >" withString:@""];
    NSLog(@"%@", modifiedTemp);     // gives desired output
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    
    NSData *completedData = [modifiedTemp dataUsingEncoding:NSUTF8StringEncoding]; // necessary for completion
//    [self.webView loadData:completedData MIMEType:nil textEncodingName:nil baseURL:self.url];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:completedData options:options documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    
    return completedData;
}


//#pragma mark -- Visual Format Language Constants
//
//NSString *const kNameLabelHorizontal = @"H:|-[_nameLabel]-|";
//NSString *const kNameLabelVertical = @"V:|-[_nameLabel]-|";
//NSString *const kStatusLabelHorizontal = @"H:|-[_statusLabel]-|";
//NSString *const kStatusLabelVertical = @"V:|-[_statusLabel]-|";
//NSString *const kTextLabelHorizontal = @"H:|-[_textLabel]-|";
//NSString *const kTextLabelVertical = @"V:|-[_textLabel]|";
//NSString *const kDateLabelHorizontal = @"H:|-[_dateLabel]-|";
//NSString *const kDateLabelVertical = @"V:|-[_dateLabel]|";
//NSString *const kTimeLabelHorizontal = @"H:|-[_timeLabel]-|";
//NSString *const kTimeLabelVertical = @"V:|-[_timeLabel]|";
//
//double const kXCoordinateServicePage = 20.0f;
//double const kFrameWidthServicePage = 280.0f;
//double const kFrameHeightLesserServicePage = 20.0f;
//double const kFrameHeightGreaterServicePage = 40.0f;
//
//- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        self.title = @"Service Changes";
//        self.tabBarItem.image = [UIImage imageNamed:@"wrench"];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.title = @"Service Changes";
//    CGRect nameLabelFrame = CGRectMake(kXCoordinateServicePage, 70.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
//    CGRect statusLabelFrame = CGRectMake(kXCoordinateServicePage, 100.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
//    CGRect textLabelFrame = CGRectMake(kXCoordinateServicePage, 130.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
//    CGRect dateLabelFrame = CGRectMake(kXCoordinateServicePage, 200.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
//    CGRect timeLabelFrame = CGRectMake(kXCoordinateServicePage, 230.0f, kFrameWidthServicePage, kFrameHeightGreaterServicePage);
//    
//    self.nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
//    self.statusLabel = [[UILabel alloc] initWithFrame:statusLabelFrame];
//    self.textLabel = [[UILabel alloc] initWithFrame:textLabelFrame];
//    self.dateLabel = [[UILabel alloc] initWithFrame:dateLabelFrame];
//    self.timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
//    
//    self.nameLabel.text = self.xmlServiceData.name;
//    self.statusLabel.text = self.xmlServiceData.status;
//    self.textLabel.text = self.xmlServiceData.text;
//    self.dateLabel.text = self.xmlServiceData.date;
//    self.timeLabel.text = self.xmlServiceData.time;
//    
//    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    self.textLabel.numberOfLines = 3;
//    
//    [self.view addSubview:self.nameLabel];
//    [self.view addSubview:self.statusLabel];
//    [self.view addSubview:self.textLabel];
//    [self.view addSubview:self.dateLabel];
//    [self.view addSubview:self.timeLabel];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
