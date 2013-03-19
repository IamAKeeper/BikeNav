//
//  MapKitViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/20/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Route.h"
#import "RouteView.h"

@interface MapKitViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    BOOL firstUpdate;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *followButton;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) Route *aRoute;
@property (strong, nonatomic) RouteView *aRouteView;

@property (strong, nonatomic) CLLocation *lastLocation;


@property NSInteger pauseCount;

- (void) setUpLocationManager;
- (void) saveMapandClearOverlay;

- (void) beginNewRide;
- (void) endCurrentRide;






@end
