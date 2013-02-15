//
//  MapViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TimeDisplay.h"

@interface MapViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) User *theUser;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property IBOutlet UITextField *emailTextField;
@property IBOutlet UIButton *timeChange;

@property (strong, nonatomic) IBOutlet TimeDisplay *tDisplay;

- (IBAction) changeTime;

@end
