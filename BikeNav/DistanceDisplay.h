//
//  DistanceDisplay.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceDisplay : UIView

@property double distanceData;
@property BOOL displayState;

-(void) drawTotalDistanceWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect;
-(void) drawTotalAltitudeGainWithContext: (CGContextRef) myContext andRect: (CGRect) contextRect;

@end
