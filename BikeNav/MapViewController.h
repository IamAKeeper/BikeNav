//
//  MapViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface MapViewController : UIViewController

@property (strong, nonatomic) User *theUser;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
