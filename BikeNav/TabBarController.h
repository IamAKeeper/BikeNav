//
//  TabBarController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/13/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "HomeViewController.h"

@interface TabBarController : UITabBarController

@property (strong, nonatomic) User *theUser;
@property IBOutlet UISegmentedControl *segmentedControl;


@end
