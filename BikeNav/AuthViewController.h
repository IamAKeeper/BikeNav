//
//  AuthViewController.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TabBarController.h"


@interface AuthViewController : UIViewController <UITextFieldDelegate>


@property IBOutlet UIButton *signInButton;
@property IBOutlet UITextField *emailTextField;
@property IBOutlet UITextField *passwordTextField;

//User Data
@property (strong, nonatomic) User *theUser;

-(IBAction) loginUser;


@end
