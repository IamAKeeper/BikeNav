//
//  TabBarController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "TabBarController.h"


@interface TabBarController ()

@end

@implementation TabBarController

@synthesize theUser, segmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    
    //Tab Bar customizing!
    /*
    [self.tabBar setTintColor: [UIColor colorWithRed:244/255.0f green:133/255.0f blue:50/255.0f alpha:1.0f]];
    [self.tabBar setSelectedImageTintColor: [UIColor colorWithRed:49/255.0f green:187/255.0f blue:245/255.0f alpha:1.0f]];
     */
}
     
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
	/* Create the segmented control
    NSArray *buttonNames = [NSArray arrayWithObjects:
                            @"Start", nil];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc]
                                            initWithItems:buttonNames];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    [segmentedControl addTarget:self action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
    */
    // Add it to the navigation bar
    
    //Generate custom colors! Also, need to add color for pause
    
    MapKitViewController *homeVC = [[MapKitViewController alloc] init];
    
    
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[segmentedControl.subviews objectAtIndex:0] setTintColor:[UIColor redColor]];
         [[segmentedControl.subviews objectAtIndex:1] setTintColor:[UIColor greenColor]];;
    });
     
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) segmentAction: (UISegmentedControl *) segController
{
    
    HomeViewController *homeVC = (HomeViewController *)[[self viewControllers] objectAtIndex:0];
    NSLog(@"Hey");
    MapKitViewController *mapVC = (MapKitViewController *)[[self viewControllers] objectAtIndex:1];
    
    
    // Update the label with the segment number
    if(segController.selectedSegmentIndex == 0)
    {
        if(segController.numberOfSegments == 2)
        {
            NSLog(@"buttons animated");
            [segController insertSegmentWithTitle:@"Pause" atIndex:1 animated:YES];
            [segController setTitle:@"Continue" forSegmentAtIndex:0];
            
            [homeVC beginNewRide];
            [mapVC beginNewRide];
            
        }
        else{
            mapVC.lastLocation = nil;
            [mapVC.locationManager startUpdatingLocation];
            [homeVC.currentRide continueRideUpdates];
        }
            
    }
    else if(segController.selectedSegmentIndex == 1)
        {
            [mapVC.locationManager stopUpdatingLocation];
            mapVC.pauseCount++;
            [homeVC.currentRide pauseRideUpdates];
        }
        else
            { //selected segment == 2
                [homeVC endCurrentRide];
                [mapVC endCurrentRide];
                [homeVC.currentRide pauseRideUpdates];
                [segController removeSegmentAtIndex:1 animated:YES];
                [segController setTitle:@"Start" forSegmentAtIndex:0];
            }
}


@end
