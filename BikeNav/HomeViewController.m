//
//  ViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 1/31/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "HomeViewController.h"




@implementation HomeViewController

@synthesize displayOne, displayTwo;
@synthesize theUser,currentRide;

- (void)viewDidLoad
{

    currentRide = theUser.userRide;
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testUser{
    NSLog(@"Time elapsed: %f", [currentRide timeElapsed]);
    NSLog(@"Username: %@", theUser.userName);
    NSLog(@"StartDate: %@", currentRide.startTime);
}

- (IBAction)testViews{
    NSLog(@"ViewOne Height:%f, Width: %f, Origin: %f,%f", displayOne.bounds.size.height, displayOne.bounds.size.width, displayOne.bounds.origin.x, displayOne.bounds.origin.y);
    
}

@end
