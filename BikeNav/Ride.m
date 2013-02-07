//
//  Ride.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "Ride.h"

@implementation Ride

@synthesize distanceCovered, startTime, idleTime;

-(id)init{
    if(self = [super init])
    {
        startTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }

    return self;
}

-(double) calcAverageSpeed;{
    return distanceCovered/[self timeElapsed];
}
                     
-(NSTimeInterval)timeElapsed{
    return [startTime timeIntervalSinceNow] - idleTime;
}

@end
