//
//  ViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "HomeViewController.h"




@implementation HomeViewController

@synthesize displayOne, displayTwo;
@synthesize theUser, currentRide;
@synthesize locationManager, lastLocation;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentRide = theUser.userRide;
    
    NSTimer *timerOne = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDataWithTimer:) userInfo:displayOne repeats:YES];
    NSTimer *timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDataWithTimer:) userInfo:displayTwo repeats:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1;
    locationManager.activityType = CLActivityTypeFitness;
    [locationManager startUpdatingLocation];
    lastLocation = nil;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //Initial location
    if (lastLocation == nil)
        lastLocation = [locations lastObject];
    
    //Location Change
    CLLocation *newLocation = [locations lastObject];
    
    CLLocationDistance distanceDifference = [newLocation
                                     distanceFromLocation:lastLocation];
    NSTimeInterval timeDifference = [[newLocation timestamp]
                                     timeIntervalSinceDate:[lastLocation timestamp]];
    
    //update User's Ride data
    currentRide.idleTime = timeDifference;
    currentRide.distanceCovered += distanceDifference;
    [currentRide calcCurrentSpeedwithDistance: distanceDifference overTime:timeDifference];
    
    lastLocation = newLocation;
    
}

-(IBAction)switchDisplay:(UIButton *)sender{
    
    //Sender will be switched to gesture recognizing sliders to be placed on each DataDisplay
    
    switch (sender.tag) {
        case 1:
            if(displayOne.displayState == 4)
                displayOne.displayState = 0;
            else
                displayOne.displayState += 1;
            break;
        case 2:
            if(displayTwo.displayState == 4)
                displayTwo.displayState = 0;
            else
                displayTwo.displayState += 1;
            break;
        
    }
    
    
    

}

-(void) updateDataWithTimer:(NSTimer *) myTimer{
    
    DataDisplay *display = myTimer.userInfo;
    
    switch(display.displayState){
        case 0: //Currently used as test case for accelerate, will change.
            display.rideData = currentRide.idleTime;
            break;
        case 1: //Currently used as test case for accelerate, will change.
            display.rideData = currentRide.didAccelerate;
            break;
        case 2:
            display.rideData = currentRide.timeElapsed;
            break;
        case 3:
            display.rideData = currentRide.distanceCovered;
            break;
        case 4:
            break;
    }
    [display setNeedsDisplay];
    return;
    
}


- (IBAction)testUser{
    NSLog(@"Time elapsed: %f", [currentRide timeElapsed]);

}

- (IBAction)testViews{
    NSLog(@"ViewOne Height:%f, Width: %f, Origin: %f,%f", displayOne.bounds.size.height, displayOne.bounds.size.width, displayOne.bounds.origin.x, displayOne.bounds.origin.y);
    
}

@end
