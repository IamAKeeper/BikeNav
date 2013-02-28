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
@synthesize nameLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [currentRide pauseRideUpdates];
    
    NSLog(@"ViewDidLoad");
    
    NSTimer *timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimeWithTimer:) userInfo:nil repeats:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1;
    locationManager.activityType = CLActivityTypeFitness;
    locationManager.pausesLocationUpdatesAutomatically = YES;
    [locationManager startUpdatingLocation];
    lastLocation = nil;
    
	// Do any additional setup after loading the view, typically from a nib.4
}

- (void) viewWillAppear:(BOOL)animated{
    nameLabel.text = theUser.userName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beginNewRide
{
    NSLog(@"begun");
    currentRide = [[Ride alloc] init];
    
    NSTimer *timerOne = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateDataWithTimer:) userInfo:nil repeats:YES];
    
    NSLog(@"The user is : %@", theUser.userName);

}

//Following pause/continue methods are likely unneccessary. Can directly call method of Ride in the tabbarcontroller

- (void) pauseRide{
    NSLog(@"paused");
    [currentRide pauseRideUpdates];
}

- (void) continueRide{
    NSLog(@"continued");
    [currentRide continueRideUpdates];
}

-(void) endCurrentRide
{
    NSLog(@"ended");
    //In future, this will need to store the currentRide information into User's history before reallocating
    /*Do not realloc here, or set back to defaults. Do that on BeginNewRide. User should still be able to see data from finished ride without going to history */
    //temporary fix. don't want to directly set pause if we can help it -- should pauseRideUpdates end as well?
    [currentRide pauseRideUpdates];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //Initial location
    if (lastLocation == nil)
        lastLocation = [locations lastObject];
    
    //Custom determining to stopUpdateLocation based on time elapsed since last update. - the user is likely to have stopped. Call [currentRide pauseRide], will need to turn off pauseupdatesuato
    
    //Location Change
    CLLocation *newLocation = [locations lastObject];
    
    CLLocationDistance distanceDifference = [newLocation
                                     distanceFromLocation:lastLocation];
    
    NSInteger altitudeDifference = newLocation.altitude - lastLocation.altitude;
    
    NSTimeInterval timeDifference = [[newLocation timestamp]
                                     timeIntervalSinceDate:[lastLocation timestamp]];
    
    //update User's Ride data
    
    [currentRide updateDistanceCoveredWithDistance: distanceDifference];
    [currentRide calcCurrentSpeedwithDistance: distanceDifference overTime:timeDifference];
    [currentRide calculateAltitudeGainedWithDistance: altitudeDifference];
    
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
