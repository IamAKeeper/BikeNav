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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [segmentedControl addTarget:self action:@selector(segmentAction:)
               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) segmentAction: (UISegmentedControl *) segController
{
    HomeViewController *homeView = (HomeViewController *)[[self viewControllers] objectAtIndex:0];
    // Update the label with the segment number
    if(segController.selectedSegmentIndex == 0)
    {
        if(segController.numberOfSegments == 2)
        {
            [segController insertSegmentWithTitle:@"Pause" atIndex:1 animated:YES];
            [segController setTitle:@"Continue" forSegmentAtIndex:0];
            [homeView beginNewRide];
        }
        else{
            [homeView continueRide];
        }
            
    }
    else if(segController.selectedSegmentIndex == 1){
        
        [homeView pauseRide];
        }
        else{
            [homeView endCurrentRide];
            [segController removeSegmentAtIndex:1 animated:YES];
            [segController setTitle:@"Start" forSegmentAtIndex:0];
        }
}




@end
