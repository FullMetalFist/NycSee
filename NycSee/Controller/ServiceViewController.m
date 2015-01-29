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
    CGRect topOff = self.textView.frame;
    topOff.origin.y = 30;
    self.textView.frame = topOff;
    
    self.textView.editable = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    // lets take this a bit further and remove <STRONG>,</STRONG>,<br/>,<P>,</P> tags.
    // Â will not disappear
    // remove <text />,Show Reroute Details
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<STRONG>" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"</STRONG>" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"Â" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<text />" withString:@"<br/><br/>"];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"Show Reroute Details" withString:@""];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    
    NSData *completedData = [modifiedTemp dataUsingEncoding:NSUTF8StringEncoding]; // necessary for completion
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:completedData options:options documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    
    return completedData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
