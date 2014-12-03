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
    
    Annotation *exitAnnotation = (Annotation *)annotation;
    if ([exitAnnotation.exitType isEqualToString:@"Elevator"]) {
        self.image = [UIImage imageNamed:@"green.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Escalator"]) {
        self.image = [UIImage imageNamed:@"orange.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Door"]) {
        self.image = [UIImage imageNamed:@"blue.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Easement"]) {
        self.image = [UIImage imageNamed:@"purple.png"];
    } else {
        self.image = [UIImage imageNamed:@"red.png"];
    }
    
    self.enabled = YES;
    self.canShowCallout = YES;
    
    return self;
}

@end
