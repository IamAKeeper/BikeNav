//
//  SpeedDisplay.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeedDisplay : UIView

@property double speedData;
@property BOOL displayState;

-(void) drawSpeedWithContext:(CGContextRef)myContext andRect:(CGRect)contextRect;

@end
