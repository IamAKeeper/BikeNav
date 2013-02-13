//
//  ViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDisplay.h"
#import <CoreLocation/CoreLocation.h>

#include "User.h"

@interface HomeViewController : UIViewController <CLLocationManagerDelegate>

//Define views for displaying information
@property (nonatomic, retain) IBOutlet DataDisplay *displayOne;
@property (nonatomic, retain) IBOutlet DataDisplay *displayTwo;

//Associated property of the current Ride and User
@property Ride *currentRide;
@property (strong, nonatomic) User *theUser;

//CoreLocation properties
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;

//TestButtons
@property IBOutlet UIButton *userTestButton;

-(IBAction)testUser;

-(IBAction)testViews;

-(IBAction)switchDisplay:(UIButton *)sender;

-(void) updateDataWithTimer: (NSTimer *) myTimer;

@end
