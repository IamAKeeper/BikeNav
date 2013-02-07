//
//  IndexViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/7/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface IndexViewController : UIViewController

@property (strong, nonatomic) User *theUser;

@property IBOutlet UIButton *continueRideButton;
@property IBOutlet UIButton *startRideButton;
@property IBOutlet UIButton *endRideButton;
@property IBOutlet UIButton *historyButton;
@property IBOutlet UIButton *settingsButton;

- (IBAction)continueRide;
- (IBAction)startNewRide:(id)sender;
- (IBAction)endRide;
- (IBAction)goToHistory;
- (IBAction)goToSettings;

@end
