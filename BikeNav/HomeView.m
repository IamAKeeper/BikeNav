//
//  HomeView.m
//  BikeNav
//
//  Created by Russell Wyatt on 3/12/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "HomeView.h"
#import <CoreGraphics/CoreGraphics.h>

#define kGradientTopColor            {105.0f/255.0f, 179.0f/255.0f, 216.0f/255.0f, 1.0f}
#define kGradientBottomColor         {21.0f/255.0f, 92.0f/255.0f, 136.0f/255.0f, 1.0f}
#define kGradientTopGloss            {255.0f/255.0f, 255.0f/255.0f, 255.0f/255.0f, 0.35f}
#define kGradientBottomGloss         {255.0f/255.0f, 255.0f/255.0f, 255.0f/255.0f, 0.05f}

@implementation HomeView

@synthesize tDisplay, sDisplay, dDisplay;

- (id)init
{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}


void drawLinearGradient(CGContextRef context, CGRect rect, CGColorSpaceRef space, CGColorRef startColor, CGColorRef endColor)
{
    
    CGContextClipToRect(context, rect);
    
    CGFloat colorLocations[] = { 0.0f, 1.0f };
    
    CFMutableArrayRef colorArray = CFArrayCreateMutable(NULL, 2, &kCFTypeArrayCallBacks);
    CFArrayAppendValue(colorArray, startColor);
    CFArrayAppendValue(colorArray, endColor);
    CGGradientRef gradient = CGGradientCreateWithColors(space, colorArray, colorLocations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CFRelease(startColor);
    CFRelease(endColor);
    CFRelease(colorArray);
    CGGradientRelease(gradient);
    
}
void drawGlossAndGradient(CGContextRef context, CGRect rect)
{
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat topColorComponents[] = kGradientTopColor;
    CGFloat bottomColorComponents[] = kGradientBottomColor;
    CGColorRef topColor = CGColorCreate(colorSpace, topColorComponents);
    CGColorRef bottomColor = CGColorCreate(colorSpace, bottomColorComponents);
    
    CGContextSetStrokeColorWithColor(context, bottomColor);
    CGContextStrokeRectWithWidth(context, rect, 5);
    
    drawLinearGradient(context, rect, colorSpace, topColor, bottomColor);
    
    CGFloat topGlossComponents[] = kGradientTopGloss;
    CGFloat bottomGlossComponents[] = kGradientBottomGloss;
    CGColorRef topGloss = CGColorCreate(colorSpace, topGlossComponents);
    CGColorRef bottomGloss = CGColorCreate(colorSpace, bottomGlossComponents);
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y,
                                rect.size.width, rect.size.height/2);
    
    drawLinearGradient(context, topHalf, colorSpace, topGloss, bottomGloss);
    
    CGContextClip(context);
    
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect = self.bounds;
    
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, myRect);
    //Background setup
    
    //Display gradients
    
    drawGlossAndGradient(context, dDisplay.frame);
    
    drawGlossAndGradient(context, tDisplay.frame);
    
    drawGlossAndGradient(context, sDisplay.frame);
}


@end
