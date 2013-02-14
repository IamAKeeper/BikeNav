//
//  TimeDisplay.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeDisplay : UIView

@property double timeData;
@property BOOL displayState;

-(void) drawTimeWithText: (char*) timeText andContext: (CGContextRef) myContext andRect: (CGRect) contextRect;

@end
