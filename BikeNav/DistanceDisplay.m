//
//  DistanceDisplay.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "DistanceDisplay.h"



@implementation DistanceDisplay

@synthesize distanceData, displayState;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) drawTotalAltitudeGainWithContext:(CGContextRef)myContext andRect:(CGRect)contextRect   {
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    char data[20];
    sprintf(data, "%.0f",distanceData);
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/2,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 15, h/2 + 20, data, strlen(data));
    
    char *units = "meters";
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/5,
                         kCGEncodingMacRoman);
    
    CGContextShowTextAtPoint (myContext, 180, h/2 + 20, units, strlen(units));
    
}

-(void) drawTotalDistanceWithContext:(CGContextRef)myContext andRect:(CGRect)contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    char data[10];
    sprintf(data, "%04.1f",distanceData);
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/2,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 15, h/2 + 20, data, strlen(data));
    
    char *units = "meters";
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/5,
                         kCGEncodingMacRoman);
    
    CGContextShowTextAtPoint (myContext, 180, h/2 + 20, units, strlen(units));
    
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect = self.bounds;

    //Text color setup
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor( context, [UIColor orangeColor].CGColor);
    
    //Set up context for text display
    CGAffineTransform transform;
    transform = CGAffineTransformConcat(CGContextGetTextMatrix(context), CGAffineTransformMake(1.0, 0.0, 0.0,-1.0, 0.0, 0.0));
    CGContextSetTextMatrix(context, transform);
    CGContextSetTextDrawingMode (context, kCGTextFillStroke);
    
    //Call drawData with switch statement
    if (displayState)
        [self drawTotalDistanceWithContext:context andRect:myRect];
    else
        [self drawTotalAltitudeGainWithContext:context andRect: myRect];

}


@end
