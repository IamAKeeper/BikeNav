//
//  ViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistanceDisplay.h"
#import "SpeedDisplay.h"
#import "TimeDisplay.h"
#import <CoreLocation/CoreLocation.h>
#import "MapKitViewController.h"
#import "HomeView.h"

#include "User.h"

@interface HomeViewController : UIViewController <CLLocationManagerDelegate>

//Define views for displaying information
@property (nonatomic, retain) IBOutlet DistanceDisplay *dDisplay;
@property (nonatomic, retain) IBOutlet SpeedDisplay *sDisplay;
@property (nonatomic, retain) IBOutlet TimeDisplay *tDisplay;

//The mapkit view
@property (strong, nonatomic) MapKitViewController *mapVC;

//Associated property of the current Ride and User
@property Ride *currentRide;
@property (strong, nonatomic) User *theUser;

//CoreLocation properties
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;

-(IBAction)switchDisplay:(UITapGestureRecognizer *) sender;

-(void) updateDataWithTimer: (NSTimer *) myTimer;
-(void) updateTimeWithTimer: (NSTimer *) myTimer;

-(void) beginNewRide;
-(void) endCurrentRide;

@end
