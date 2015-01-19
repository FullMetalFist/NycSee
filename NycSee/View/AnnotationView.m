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
    if (self) {
        [self setAnnotationData:annotation];
    }
    
    return self;
}

- (void)setAnnotationData:(id<MKAnnotation>)annotation
{
    Annotation *exitAnnotation = (Annotation *)annotation;
    if ([exitAnnotation.exitType isEqualToString:@"Elevator"]) {
        self.image = [UIImage imageNamed:@"greenEl.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Escalator"]) {
        self.image = [UIImage imageNamed:@"orangeEs.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Door"]) {
        self.image = [UIImage imageNamed:@"blueD.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Easement"]) {
        self.image = [UIImage imageNamed:@"purpleEa.png"];
    } else if ([exitAnnotation.exitType isEqualToString:@"Stair"]){
        self.image = [UIImage imageNamed:@"redSt.png"];
    }
    
    self.enabled = YES;
    self.canShowCallout = YES;
}

@end
