//
//  Ride.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "Ride.h"
#import "AppDelegate.h"



@implementation Ride 

@synthesize distanceCovered, startTime, idleTime;
@synthesize didAccelerate, accelCount, accelSum;


-(id)init{
    if(self = [super init])
    {
        startTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        accelCount = 0;
    }
    
    NSLog(@"Ride initialized");
    [self beginAccelerometerUpdates];

    return self;
}

-(void) beginAccelerometerUpdates
{
    double __block accelY;
    CMMotionManager *mManager = [(AppDelegate *)[[UIApplication sharedApplication] delegate] rideManager];
    NSLog(@"begin accelerometer updates");
    
    if ([mManager isDeviceMotionAvailable] == YES) {
        [mManager setDeviceMotionUpdateInterval:0.1];
        [mManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceData, NSError *error) {
                //NSLog(@"y acceleration: %f", deviceData.userAcceleration.y);
                 accelY = deviceData.userAcceleration.y;
            
                if(accelY <= 0 && accelCount <= 0)
                {
                    accelCount -= 1;
                    accelSum += accelY;
                    if(accelCount == -7){
                        if(accelSum <= -3)
                            didAccelerate -= 2;
                        else
                            didAccelerate -= 1;
                        accelCount = 0;
                    }
                }
                else if (accelY >= 0 && accelCount >= 0)
                    {
                        accelCount += 1;
                        accelSum += accelY;
                        if(accelCount == 10){
                            if(accelSum >= 3)
                                didAccelerate += 2;
                            else
                                didAccelerate += 1;
                            accelCount = 0;
                        }
                    }
                else{
                        accelCount = 0;
                        accelSum = 0.0;
                }
            //NSLog(@"modifiers: %d", didAccelerate);
            //NSLog(@"count: %d", accelCount);
            }];
         }
    else
        NSLog(@"accelerometer not available");

}

-(double) calcAverageSpeed{
    //return distanceCovered/[self timeElapsed];
    return 5.0;
}

-(double) calcCurrentSpeedwithDistance: (double) distance overTime: (NSTimeInterval) time{
    return distance/time*(M_S_TO_MI_HR);
}

                     
-(NSTimeInterval)timeElapsed{
    return [startTime timeIntervalSinceNow] - idleTime;
}

@end
