//
//  ViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "HomeViewController.h"




@implementation HomeViewController

@synthesize dDisplay, sDisplay, tDisplay;
@synthesize theUser, currentRide;
@synthesize locationManager, lastLocation;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentRide = theUser.userRide;
    
    NSTimer *timerOne = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateDataWithTimer:) userInfo:nil repeats:YES];
    NSTimer *timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimeWithTimer:) userInfo:nil repeats:YES];
    
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

-(IBAction)switchDisplay:(UITapGestureRecognizer *)sender{
    
    //Switch displayed data
    switch (sender.view.tag) {
        case 1:
            if(dDisplay.displayState)
                dDisplay.displayState = FALSE;
            else
                dDisplay.displayState = TRUE;
            break;
        case 2:
            if(sDisplay.displayState)
                sDisplay.displayState = FALSE;
            else
                sDisplay.displayState = TRUE;
            break;
        case 3:
            if(tDisplay.displayState)
                tDisplay.displayState = FALSE;
            else
                tDisplay.displayState = TRUE;
            break;
        
    }
    
    //Update view
    [self updateDataWithTimer:nil];

}

-(void) updateDataWithTimer:(NSTimer *) myTimer{
    
    //Speed Display Data and Draw Update
    if(sDisplay.displayState)
        sDisplay.speedData = currentRide.currentSpeed;
    else
        sDisplay.speedData = [currentRide calcAverageSpeed];
    
    [sDisplay setNeedsDisplay];
    
    //Distance Display Data and Draw Update
    if(dDisplay.displayState)
        dDisplay.distanceData = currentRide.distanceCovered;
    else
        dDisplay.distanceData = currentRide.altitudeGain;
    
    [dDisplay setNeedsDisplay];
    
}

-(void) updateTimeWithTimer:(NSTimer *)myTimer{
    
    if(tDisplay.displayState)
        tDisplay.timeData = [currentRide timeElapsed];
    [tDisplay setNeedsDisplay];
}


- (IBAction)testUser{
    NSLog(@"Time elapsed: %f", [currentRide timeElapsed]);

}



@end
