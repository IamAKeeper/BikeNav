//
//  DataDisplay.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/5/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataDisplay : UIView

@property double rideData;
@property int displayState;

-(void) drawCurrentSpeedWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect;
-(void) drawtotalDistanceWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect;
-(void) drawAverageSpeedWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect;
-(void) drawTimeWithText: (char*) timeText andContext: (CGContextRef) myContext andRect: (CGRect) contextRect;

-(void)updateDisplayState;


@end
