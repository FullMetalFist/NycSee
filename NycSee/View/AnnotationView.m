//
//  AnnotationView.m
//  NycSee
//
//  Created by Michael Vilabrera on 12/1/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "AnnotationView.h"
#import "Annotation.h"

@implementation AnnotationView

- (instancetype) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    NSArray *reuseIdentifierArray = @[@"pinGreen",@"pinOrange",@"pinBlue",@"pinPurple",@"pinRed"];
    
    // set pin types:
    // elevator -   green
    // escalator-   orange
    // door     -   blue
    // easement -   purple
    // stairs   -   red
    
    Annotation *exitAnnotation = (Annotation *)annotation;
    if ([exitAnnotation.exitType isEqualToString:@"Elevator"] && [self.reuseIdentifier isEqualToString:reuseIdentifierArray[0]]) {
        self.color = [UIColor greenColor];
        self.image = [UIImage imageNamed:@"green.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Escalator"] && [self.reuseIdentifier isEqualToString:reuseIdentifierArray[1]]) {
        self.color = [UIColor orangeColor];
        self.image = [UIImage imageNamed:@"orange.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Door"] && [self.reuseIdentifier isEqualToString:reuseIdentifierArray[2]]) {
        self.color = [UIColor blueColor];
        self.image = [UIImage imageNamed:@"blue.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Easement"] && [self.reuseIdentifier isEqualToString:reuseIdentifierArray[3]]) {
        self.color = [UIColor purpleColor];
        self.image = [UIImage imageNamed:@"purple.png"];
    } else {
        self.color = [UIColor redColor];
        self.image = [UIImage imageNamed:@"red.png"];
    }
    
    self.enabled = YES;
    self.canShowCallout = YES;
    
    return self;
}

@end
