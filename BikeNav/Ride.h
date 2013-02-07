//
//  Ride.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ride : NSObject

@property double distanceCovered;
@property NSDate *startTime;
@property double idleTime;
//GPS information

-(id)init;
-(double) calcAverageSpeed;
-(NSTimeInterval) timeElapsed;
-(NSTimeInterval)calcIdleTime;

@end
