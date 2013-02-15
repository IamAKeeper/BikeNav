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

//Acceleromter properties
@property int __block didAccelerate;
@property int __block accelCount;
@property double __block accelSum;

//Update display property methods

- (double) updateDistanceCoveredWithDistance: (double) distance;
- (NSTimeInterval) updateTimeElapsed;
- (double) calcCurrentSpeedwithDistance: (double) distance overTime: (NSTimeInterval) time;
- (NSInteger) calculateAltitudeGained;

//Control methods
- (void) pauseRideUpdates;
- (void) continueRideUpdates;

@end
