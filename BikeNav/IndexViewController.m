//
//  IndexViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/7/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "IndexViewController.h"


@implementation IndexViewController

@synthesize theUser;

@synthesize continueRideButton, startRideButton, endRideButton, historyButton, settingsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewRide"]) {
        //temporary ride init
        theUser.userRide = [[Ride alloc] init];
        HomeViewController *destViewController = segue.destinationViewController;
        destViewController.theUser = theUser;
    }
}

@end
