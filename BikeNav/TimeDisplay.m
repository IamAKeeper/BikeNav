//
//  TimeDisplay.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "TimeDisplay.h"
#import <CoreGraphics/CoreGraphics.h>

#define kGradientTopColor            {105.0f/255.0f, 179.0f/255.0f, 216.0f/255.0f, 1.0f}
#define kGradientBottomColor         {21.0f/255.0f, 92.0f/255.0f, 136.0f/255.0f, 1.0f}
#define kGradientTopGloss            {255.0f/255.0f, 255.0f/255.0f, 255.0f/255.0f, 0.35f}
#define kGradientBottomGloss         {255.0f/255.0f, 255.0f/255.0f, 255.0f/255.0f, 0.1f}


@implementation TimeDisplay

@synthesize timeData, displayState, lightBlueColor, darkBlueColor;

- (id)init
{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
    }
    return self;
}

-(void) drawTimeWithText: (char*)timeText andContext:(CGContextRef) myContext andRect: (CGRect) contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/2.5,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 20, h/2 + 10, timeText, strlen(timeText));
    
}

-(char *) formattedCurrentTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    
    NSDate *currentTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    return [[dateFormatter stringFromDate:currentTime] UTF8String];
    
}

- (char *)formattedTimeDuration
{
    double duration = timeData*-1;
    NSInteger hours = floor(duration/3200);
    NSInteger minutes = floor(duration/60);
    double seconds = duration - (minutes * 60);
    return [[NSString stringWithFormat:@"%02d:%02d:%04.1f", hours, minutes, seconds] UTF8String];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect = self.bounds;
    
    //Background setup

    CGContextStrokeRectWithWidth(context, myRect, 6);
    
    //Text color setup
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor( context, [UIColor orangeColor].CGColor);
    
    //Set up context for text display
    CGAffineTransform transform;
    transform = CGAffineTransformConcat(CGContextGetTextMatrix(context), CGAffineTransformMake(1.0, 0.0, 0.0,-1.0, 0.0, 0.0));
    CGContextSetTextMatrix(context, transform);
    CGContextSetTextDrawingMode (context, kCGTextFillStroke);
    
    //Call drawTime with switch statement
    if (displayState)
        [self drawTimeWithText:[self formattedTimeDuration] andContext:context andRect:myRect];
    else
        [self drawTimeWithText:[self formattedCurrentTime] andContext:context andRect:myRect];

}


@end
