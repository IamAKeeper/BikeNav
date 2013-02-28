//
//  MapKitViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/20/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "MapKitViewController.h"
#import "Route.h"
#import "RouteView.h"

@interface MapKitViewController ()

@end

@implementation MapKitViewController

@synthesize mapView, routePoints;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void) viewWillAppear:(BOOL)animated{
    
    
    
    
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.delegate = self;
    routePoints = [[NSMutableArray alloc] init];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation
{
    
    CLLocationCoordinate2D currentLocation = [aMapView.userLocation.location coordinate];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKMapRect viewRect = [self mapRectForCoordinateRegion:viewRegion];
    
    [aMapView setCenterCoordinate:currentLocation];
    [aMapView setRegion:viewRegion animated:NO];
    
    
    Route *routePoint = [[Route alloc] initWithCenterCoordinate:aMapView.userLocation.location.coordinate rect: viewRect];
    
    [routePoints addObject:routePoint];
    
    if ([routePoints count] >= 2){
        
        NSLog(@"number of points: %d", [routePoints count]);
        [mapView addOverlay:routePoint];
        
    }
    
}

- (MKOverlayView *) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[Route class]])
    {
        
        NSLog(@"attempting to init routeview");
        RouteView *aView = [[RouteView alloc] initWithOverlayAndPoints:overlay points:routePoints];
        
        return aView;
    }
    
    return nil;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

- (MKMapRect)mapRectForCoordinateRegion:(MKCoordinateRegion)coordinateRegion
{
    CLLocationCoordinate2D topLeftCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               + (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               - (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint topLeftMapPoint = MKMapPointForCoordinate(topLeftCoordinate);
    
    CLLocationCoordinate2D bottomRightCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               - (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               + (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint bottomRightMapPoint = MKMapPointForCoordinate(bottomRightCoordinate);
    
    MKMapRect mapRect = MKMapRectMake(topLeftMapPoint.x,
                                      topLeftMapPoint.y,
                                      fabs(bottomRightMapPoint.x-topLeftMapPoint.x),
                                      fabs(bottomRightMapPoint.y-topLeftMapPoint.y));
    
    return mapRect;
}


@end
