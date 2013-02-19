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

@synthesize theUser, nameLabel, emailTextField, timeChange, tDisplay;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"map viewdidload");
	// Do any additional setup after loading the view.
    
    HomeViewController *homeView = (HomeViewController *)[[self.tabBarController viewControllers] objectAtIndex:0];
    theUser = homeView.theUser;
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
