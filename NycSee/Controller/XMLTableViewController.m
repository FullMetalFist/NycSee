//
//  XMLTableViewController.m
//  NycSee
//
//  Created by Michael Vilabrera on 7/24/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "XMLTableViewController.h"
#import "XMLTableViewCell.h"

#import "Constant.h"
#import "XMLData.h"

NSString *const CellOutageIdentifier = @"outage";

@interface XMLTableViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *outages;
@property (nonatomic, strong) NSMutableString *currentElement;
@property (nonatomic, strong) XMLData *xmlData;

@property (nonatomic, strong) UITableViewCell *cell;

@end

@implementation XMLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Outage List";
        self.tabBarItem.image = [UIImage imageNamed:@"Outages"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Outage List";

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellOutageIdentifier];
    
    NSURL *url = [[NSURL alloc] initWithString:XML_DATA_URL];   // nsurlsession
    self.outages = [NSMutableArray array];
    self.allDataFromXML = [NSMutableArray array];
    self.xmlData = [[XMLData alloc] init];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allDataFromXML count];
}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static XMLTableViewCell *sizingCell;
//    static dispatch_once_t once_token;
//    
//    dispatch_once(&once_token, ^{
//        sizingCell = [[XMLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    });
////    XMLData *data = self.outages[indexPath.row];
////    CGFloat (^calcCellHeight)(XMLTableViewCell *, NSString *) = ^ CGFloat(XMLTableViewCell *sizingCell, NSString *labelText){
////        
////        return [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
////    };
//    CGSize size = [self.cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellOutageIdentifier forIndexPath:indexPath];
    // Configure the cell...
    XMLData *theData = self.allDataFromXML[indexPath.row];
    self.cell.textLabel.text = theData.station;
    
    return self.cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailVC = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
    XMLData *theData = self.allDataFromXML[indexPath.row];
    self.detailVC.xmlData = theData;
    [self.navigationController pushViewController:self.detailVC animated:NO];
}

#pragma mark -- XML Parser methods

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"outage"]) {
        self.xmlData = [[XMLData alloc] init];
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
    if ([elementName isEqualToString:@"outage"]) {
        [self.allDataFromXML addObject:self.xmlData];
        return;
    }
    else if ([elementName isEqualToString:@"NYCOutages"]) {
        return;
    } else {
        [self parseDataWithElementName:elementName];
    }
}

- (void) parseDataWithElementName:(NSString *)elementName
{
    if ([elementName isEqualToString:@"station"]) {
        self.xmlData.station = self.currentElement;
    }
    else if ([elementName isEqualToString:@"borough"]) {
        self.xmlData.borough = self.currentElement;
    }
    else if ([elementName isEqualToString:@"trainno"]) {
        self.xmlData.trainno = self.currentElement;
    }
    else if ([elementName isEqualToString:@"equipmenttype"]) {
        if ([self.currentElement isEqualToString:@"EL"]) {
            self.xmlData.equipment = @"ELEVATOR";
        } else if ([self.currentElement isEqualToString:@"ES"]) {
            self.xmlData.equipment = @"ESCALATOR";
        } else {
            self.xmlData.equipment = self.currentElement;
        }
    } else if ([elementName isEqualToString:@"serving"]) {
        self.xmlData.serving = self.currentElement;
    } else if ([elementName isEqualToString:@"outagedate"]) {
        self.xmlData.outageDate = self.currentElement;
    } else if ([elementName isEqualToString:@"estimatedreturntoservice"]) {
        self.xmlData.estimatedReturnToService = self.currentElement;
    }
}

@end
