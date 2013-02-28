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

@property CLLocationCoordinate2D point;
@property (nonatomic) MKMapRect boundingMapRect;

- (id) initWithCenterCoordinate:(CLLocationCoordinate2D) aCoord rect:(MKMapRect) boundingRect;


@end
