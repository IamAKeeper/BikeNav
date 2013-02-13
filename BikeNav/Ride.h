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
@property NSDate *startTime;
@property double idleTime;
@property double currentSpeed;
@property double currentLocation;

//Acceleromter properties
@property int __block didAccelerate;
@property int __block accelCount;
@property double __block accelSum;


//GPS properties


//Methods
-(id)init;
-(double) calcAverageSpeed;
-(NSTimeInterval) timeElapsed;
-(NSTimeInterval)calcIdleTime;
-(double) calcCurrentSpeedwithDistance: (double) distance overTime: (NSTimeInterval) time;

@end
