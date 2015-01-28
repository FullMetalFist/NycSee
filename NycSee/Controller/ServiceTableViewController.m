//
//  ServiceTableViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 1/19/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "ServiceTableViewController.h"

#import "XMLServiceData.h"
#import "Constant.h"

NSString *const CellServiceIdentifier = @"service";

@interface ServiceTableViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *serviceChanges;
@property (nonatomic, strong) NSMutableString *currentElement;
@property (nonatomic, strong) XMLServiceData *serviceData;

@property (nonatomic, strong) NSMutableString *textString;
@property (nonatomic, strong) NSMutableDictionary *textDict;
@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ServiceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Service Changes";
        self.tabBarItem.image = [UIImage imageNamed:@"wrench"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Service Changes";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellServiceIdentifier];
    
    NSURL *url = [[NSURL alloc] initWithString:SERVICE_STATUS_URL];
    self.serviceChanges = [NSMutableArray array];
    self.allDataFromService = [NSMutableArray array];
    self.serviceData = [[XMLServiceData alloc] init];
    self.textDict = [NSMutableDictionary dictionary];
    
    self.textView = [[UITextView alloc] init];
    
    NSError *error = [[NSError alloc] init];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url options:NSUTF8StringEncoding error:&error];
    data = [self replaceHTMLentities:data];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark - remove HTML ambiguities

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
//    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"Â" withString:@""];
    modifiedTemp = [modifiedTemp stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
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

    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:completedData options:options documentAttributes:nil error:nil];
    self.textView.attributedText = attributedString;
    
//    NSData *completedData = [modifiedTemp dataUsingEncoding:NSUTF8StringEncoding];
    return completedData;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allDataFromService count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellServiceIdentifier forIndexPath:indexPath];
    // Configure the cell...
    XMLServiceData *theData = self.allDataFromService[indexPath.row];
    NSString *giveInfo = [NSString stringWithFormat:@"%@ %@", theData.name, theData.status];
    cell.textLabel.text = giveInfo;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.serviceVC = [[ServiceViewController alloc] initWithNibName:nil bundle:nil];
    XMLServiceData *theData = self.allDataFromService[indexPath.row];
    self.serviceVC.xmlServiceData = theData;
    [self.navigationController pushViewController:self.serviceVC animated:YES];
}

#pragma mark -- XML Parser methods

- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"line"]) {
        self.serviceData = [[XMLServiceData alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentElement == nil) {
        self.currentElement = [NSMutableString string];
    }
    self.currentElement = [NSMutableString stringWithFormat:@"%@", string];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"line"]) {
        [self.allDataFromService addObject:self.serviceData];
        return;
    }
    else if ([elementName isEqualToString:@"subway"]) {
        return;
    } else {
        [self parseDataWithElementName:elementName];
    }
}

- (void) parseDataWithElementName:(NSString *)elementName
{
    if ([elementName isEqualToString:@"name"]) {
        self.serviceData.name = self.currentElement;
    }
    else if ([elementName isEqualToString:@"status"]) {
        self.serviceData.status = self.currentElement;
    }
    else if ([elementName isEqualToString:@"text"]) {
        self.serviceData.text = [self.serviceData.text stringByAppendingString:self.currentElement];
        NSLog(@"%@", self.currentElement);
    } else if ([elementName isEqualToString:@"Date"]) {
        self.serviceData.date = self.currentElement;
    } else if ([elementName isEqualToString:@"Time"]) {
        self.serviceData.time = self.currentElement;
    }
}

@end
