//
//  ViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDisplay.h"

#include "User.h"

@interface HomeViewController : UIViewController

@property (nonatomic, retain) IBOutlet DataDisplay *displayOne;
@property (nonatomic, retain) IBOutlet DataDisplay *displayTwo;
@property Ride *currentRide;

@property (strong, nonatomic) User *theUser;
@property IBOutlet UIButton *userTestButton;

-(IBAction)testUser;

-(IBAction)testViews;

@end
