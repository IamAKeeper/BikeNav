//
//  DataDisplay.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/5/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "DataDisplay.h"

@implementation DataDisplay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, self.bounds);
    
    NSLog(@"context filled");
}


@end
