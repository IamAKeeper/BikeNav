//
//  Route.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/26/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Route : NSObject <MKOverlay>
{
    MKMapPoint *points;
    NSUInteger pointCount;
    NSUInteger pointSpace;
    
    MKMapRect boundingMapRect;
}

@property (readonly) MKMapPoint *points;
@property (readonly) NSUInteger pointCount;

- (id) initWithCenterCoordinate:(CLLocationCoordinate2D) coord;

- (MKMapRect) addCoordinate:(CLLocationCoordinate2D) coord;

- (BOOL) wasPaused;



@end
