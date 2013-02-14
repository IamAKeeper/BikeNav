//
//  MapViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "MapViewController.h"
#import "TabBarController.h"

@implementation MapViewController

@synthesize theUser, nameLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"map viewdidload");
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    
    NSLog(@"view will appear");
    HomeViewController *homeView = (HomeViewController *)[[self.tabBarController viewControllers] objectAtIndex:0];
    theUser = homeView.theUser;
    
    nameLabel.text = [NSString stringWithFormat:@"%f",[theUser.userRide timeElapsed]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
