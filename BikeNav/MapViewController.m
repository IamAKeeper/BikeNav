//
//  MapViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "MapViewController.h"
#import "TabBarController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation MapViewController{
    GMSMapView *mapView_;
}

@synthesize theUser, nameLabel, emailTextField, timeChange, tDisplay;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"map viewdidload");
	// Do any additional setup after loading the view.
    
    HomeViewController *homeView = (HomeViewController *)[[self.tabBarController viewControllers] objectAtIndex:0];
    theUser = homeView.theUser;
}

- (void) loadView{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.8683
                                                            longitude:151.2086
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(-33.8683, 151.2086);
    options.title = @"Sydney";
    options.snippet = @"Australia";
    [mapView_ addMarkerWithOptions:options];
}

-(void) viewWillAppear:(BOOL)animated
{
    
    NSLog(@"view will appear");
    
    nameLabel.text = [NSString stringWithFormat:@"%f",[theUser.userRide updateTimeElapsed]];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegain:withEvent:");
    [self.view endEditing:YES];
    theUser.userName = emailTextField.text;
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) changeTime{
    
    tDisplay.timeData = [theUser.userRide timeElapsed];
    if(tDisplay.displayState)
        tDisplay.displayState = NO;
    else
        tDisplay.displayState = YES;
    
    [tDisplay setNeedsDisplay];
}


@end
