//
//  DataDisplay.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/5/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "DataDisplay.h"

@implementation DataDisplay

@synthesize rideData, displayState;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        rideData = 0.0;
        displayState = 0;
    }
    return self;
}

-(void) drawCurrentSpeedWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    char data[10];
    sprintf(data, "%f",rideData);
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/3.5,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 10, h/2, data, strlen(data));
    
}
-(void) drawtotalDistanceWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    char data[10];
    sprintf(data, "%f",rideData);
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/3.5,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);

    CGContextShowTextAtPoint (myContext, 10, h/2, data, strlen(data));
    
}
-(void) drawTimeWithText: (char*)timeText andContext:(CGContextRef) myContext andRect: (CGRect) contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/3.5,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 10, h/2, timeText, strlen(timeText));
    
}
-(void) drawAverageSpeedWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect{
    
    CGFloat w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    
    char data[10];
    sprintf(data, "%f",rideData);
    
    CGContextSelectFont (myContext,
                         "Helvetica-Bold",
                         h/3.5,
                         kCGEncodingMacRoman);
    CGContextSetCharacterSpacing (myContext, 3);
    
    CGContextShowTextAtPoint (myContext, 10, h/2, data, strlen(data));
    
}

-(char *) formattedCurrentTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    
    NSDate *currentTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    return [[dateFormatter stringFromDate:currentTime] UTF8String];
    
}

- (char *)formattedTimeDuration
{
    double duration = rideData*-1;
    NSInteger hours = floor(duration/320);
    NSInteger minutes = floor(duration/60);
    double seconds = duration - (minutes * 60);
    return [[NSString stringWithFormat:@"%d:%02d:%04.1f", hours, minutes, seconds] UTF8String];
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect = self.bounds;
    
    //To be switched to custom view drawing
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, myRect);
    
    CGContextSetRGBFillColor (context, 0, 1, 0, .5);
    CGContextSetRGBStrokeColor (context, 0, 0, 1, 1);
    
    //Set up context for text display
    CGAffineTransform transform;
    transform = CGAffineTransformConcat(CGContextGetTextMatrix(context), CGAffineTransformMake(1.0, 0.0, 0.0,-1.0, 0.0, 0.0));
    CGContextSetTextMatrix(context, transform);
    CGContextSetTextDrawingMode (context, kCGTextFillStroke);
    
    //Call drawData with switch statement
    switch(displayState){
        case 0:
            [self drawCurrentSpeedWithContext:context andRect:myRect];
            break;
        case 1:
            [self drawtotalDistanceWithContext:context andRect:myRect];
            break;
        case 2:
            [self drawTimeWithText:[self formattedTimeDuration] andContext:context andRect:myRect];
            break;
        case 3:
            [self drawAverageSpeedWithContext:context andRect:myRect];
            break;
        case 4:
            [self drawTimeWithText:[self formattedCurrentTime] andContext:context andRect:myRect];
            break;
    }

}


@end
