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

@property (nonatomic, strong) UITableViewCell *cell;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Service Changes";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellServiceIdentifier];
    NSURL *url = [[NSURL alloc] initWithString:SERVICE_STATUS_URL];
    self.serviceChanges = [NSMutableArray array];
    self.serviceData = [[XMLServiceData alloc] init];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.serviceChanges count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellServiceIdentifier forIndexPath:indexPath];
    // Configure the cell...
    XMLServiceData *theData = self.serviceChanges[indexPath.row];
    self.cell.textLabel.text = theData.name;
    
    return self.cell;
}

#pragma mark - Navigation

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.
//}

#pragma mark -- XML Parser methods

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
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
        [self.serviceChanges addObject:self.serviceData];
        return;
    }
    else if ([elementName isEqualToString:@"service"]) {
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
    else if ([elementName isEqualToString:@"service"]) {
        self.serviceData.status = self.currentElement;
    }
    else if ([elementName isEqualToString:@"text"]) {
        self.serviceData.text = self.currentElement;
    } else if ([elementName isEqualToString:@"Date"]) {
        self.serviceData.date = self.currentElement;
    } else if ([elementName isEqualToString:@"Time"]) {
        self.serviceData.time = self.currentElement;
    }
}

@end
