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
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    CGRect topOff = self.textView.frame;
    topOff.origin.y = 40;
    self.textView.frame = topOff;
    
    self.textView.editable = NO;
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.url = [[NSURL alloc] initWithString:SERVICE_STATUS_URL];
    
    [self configureRefreshControl];
    
    [self fetchServiceStatus];
}

- (NSData *) replaceHTMLentities:(NSData *)data
{
    if (data) {
        NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        
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
        
        NSData *completedData = [modifiedTemp dataUsingEncoding:NSISOLatin1StringEncoding]; // necessary for completion
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:completedData options:options documentAttributes:nil error:nil];
            self.textView.attributedText = attributedString;
        }];
        
        return completedData;
    }
    else {
        return nil;
    }
}

- (void) configureRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchServiceStatus) forControlEvents:UIControlEventValueChanged];
    [self.textView addSubview:self.refreshControl];
}

- (void) fetchServiceStatus {
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:self.url options:NSISOLatin1StringEncoding error:nil];
        data = [self replaceHTMLentities:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.view addSubview:self.textView];
            [self.refreshControl endRefreshing];
        }];
    }];       // getting 0xbbadbeef when dispatch_async is run
}

@end
