//
//  ViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "HomeViewController.h"
#import "TabBarController.h"




@implementation HomeViewController

@synthesize dDisplay, sDisplay, tDisplay;
@synthesize theUser, currentRide;
@synthesize locationManager, lastLocation;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [currentRide pauseRideUpdates];
    

    
    NSTimer *timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimeWithTimer:) userInfo:nil repeats:YES];
    
    NSTimer *timerOne = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateDataWithTimer:) userInfo:nil repeats:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1;
    locationManager.activityType = CLActivityTypeFitness;
    locationManager.pausesLocationUpdatesAutomatically = YES;
    lastLocation = nil;
    
	// Do any additional setup after loading the view, typically from a nib.4
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beginNewRide
{
    currentRide = [[Ride alloc] init];
    [locationManager startUpdatingLocation];
}

-(void) endCurrentRide
{

    //This space reserved for saving ride information to backend
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //Initial location
    if (lastLocation == nil)
    {
        lastLocation = [locations lastObject];
        return;
    }
    
    //Custom determining to stopUpdateLocation based on time elapsed since last update. - the user is likely to have stopped. Call [currentRide pauseRide], will need to turn off pauseupdatesuato
    
    //Location Change
    NSInteger i;
    CLLocation *newLocation;
    
    for( i = [locations count] - 1; i >= 0; i--)
    {

        if(((CLLocation *)[locations objectAtIndex: i]).horizontalAccuracy > 0)
        {
            newLocation = [locations objectAtIndex: i];
            break;
        }
    }
    
    if(newLocation == nil)
        return;
    
    //Calculations for change from last good location point
    
    CLLocationDistance distanceDifference = [newLocation
                                     distanceFromLocation:lastLocation];
    
    NSInteger altitudeDifference = newLocation.altitude - lastLocation.altitude;
    
    NSTimeInterval timeDifference = [[newLocation timestamp]
                                     timeIntervalSinceDate:[lastLocation timestamp]];
    
    //update User's Ride data
    
    [currentRide updateRideWithDistance:distanceDifference andAltitude:altitudeDifference overTime:timeDifference];
    
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
        sDisplay.speedData = [currentRide averageSpeed];
    
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
        tDisplay.timeData = [currentRide updateTimeElapsed];
    [tDisplay setNeedsDisplay];
}


@end
