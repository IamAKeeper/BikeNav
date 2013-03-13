//
//  HomeView.h
//  BikeNav
//
//  Created by Russell Wyatt on 3/12/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistanceDisplay.h"
#import "SpeedDisplay.h"
#import "TimeDisplay.h"

@interface HomeView : UIView

@property (nonatomic, retain) IBOutlet DistanceDisplay *dDisplay;
@property (nonatomic, retain) IBOutlet SpeedDisplay *sDisplay;
@property (nonatomic, retain) IBOutlet TimeDisplay *tDisplay;

@end
