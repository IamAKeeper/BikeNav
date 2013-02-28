//
//  RouteView.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/26/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RouteView : MKOverlayView

@property (strong, nonatomic) NSMutableArray *routePoints;

- (id) initWithOverlayAndPoints:(id<MKOverlay>) overlay points:(NSMutableArray *) points;

@end
