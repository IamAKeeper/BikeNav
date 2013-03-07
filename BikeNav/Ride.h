//
//  Ride.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>



@interface Ride : NSObject

//Display properties
@property double distanceCovered;
@property double currentSpeed;
@property double altitudeGain;
@property double timeElapsed;
@property double averageSpeed;

//Calculation data
@property NSDate *startTime;
@property NSDate *timeInterval;

@property BOOL paused;

//Acceleromter properties
@property int __block didAccelerate;
@property int __block accelCount;
@property double __block accelSum;

//Update Ride data methods

- (NSTimeInterval) updateTimeElapsed;
- (void) updateRideWithDistance: (double) distance
                    andAltitude: (NSInteger)altitude
                       overTime: (NSTimeInterval) time;

//Control methods
- (void) pauseRideUpdates;
- (void) continueRideUpdates;

@end
