//
//  Route.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/26/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize point, boundingMapRect;

- (id) initWithCenterCoordinate:(CLLocationCoordinate2D)aCoord rect: (MKMapRect) boundingRect
{
    if(self = [super init])
    {
        point = aCoord;
        boundingMapRect = boundingRect;
        NSLog(@"Overlay initialized");
    }
    
    return self;
}

@end
