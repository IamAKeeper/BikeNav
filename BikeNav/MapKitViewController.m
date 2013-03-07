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

@synthesize mapView, locationManager, aRoute, aRouteView, lastLocation, pauseCount;

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
    
    NSLog(@"Map viewdidload");
    
    [self setUpLocationManager];
    
    mapView.delegate = self;
    [mapView setUserTrackingMode:MKUserTrackingModeFollow];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation
{

   /*
    CLLocationCoordinate2D currentLocation = [aMapView.userLocation.location coordinate];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKMapRect viewRect = [self mapRectForCoordinateRegion:viewRegion];
    
    [aMapView setCenterCoordinate:currentLocation];
    [aMapView setRegion:viewRegion animated:NO];
   */ 
    
}

- (MKOverlayView *) mapView:(MKMapView *)aMapView viewForOverlay:(id<MKOverlay>)overlay
{
    
    if ([aMapView.overlays count] == (pauseCount + 1))
    {
        
        NSLog(@"New OverlayView added");
        aRouteView = [[RouteView alloc] initWithOverlay:overlay];
        
    }
    
    return aRouteView;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations)
    {
        
        CLLocation *newLocation = [locations lastObject];
        
        if (!lastLocation)
        {
            lastLocation = newLocation;
            return;
        }
        
        if ((lastLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
                (lastLocation.coordinate.longitude != newLocation.coordinate.latitude))
        {
            
            if ([mapView.overlays count] == pauseCount)
            {
                
                aRoute = [[Route alloc] initWithCenterCoordinate:newLocation.coordinate];
                [mapView addOverlay:aRoute];
                NSLog(@"New Overlay added");
                
            }
            else
            {
                MKMapRect updateRect = [aRoute addCoordinate:newLocation.coordinate];
                
                if (!MKMapRectIsNull(updateRect))
                {
                    
                    MKZoomScale currentZoomScale = (CGFloat)(mapView.bounds.size.width / mapView.visibleMapRect.size.width);
                    CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
                    updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
                    [aRouteView setNeedsDisplayInMapRect:updateRect];
                    
                }
                    
            }
            
        }
        
    }
}

- (IBAction) setTracking
{
    [mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

- (void) setUpLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    pauseCount = 0;
    
    [locationManager startUpdatingLocation];
}

- (void) saveMapandClearOverlay
{
    [mapView removeOverlays: mapView.overlays];
    
    //for now, just clears overlays. this will save the map into the ride model eventually.
}

@end
