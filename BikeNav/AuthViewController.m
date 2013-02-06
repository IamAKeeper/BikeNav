//
//  AuthViewController.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "AuthViewController.h"

@implementation AuthViewController

@synthesize signInButton;
@synthesize emailTextField, passwordTextField;

@synthesize theUser;


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

- (IBAction)loginUser
{
    
    //In the future, to be used to authenticate via back end on press
    
    //Current test case
    theUser = [[User alloc] initWithUserName:emailTextField.text andEmail:emailTextField.text];
    
    NSLog(@"User name: %@", theUser.userName);
    NSLog(@"Email: %@ and Password: %@", emailTextField.text, passwordTextField.text);
}

- (IBAction) signInViewSwitch:(id)sender{
    HomeViewController *homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    
    homeVC.theUser = theUser;
    
    [self presentViewController:homeVC animated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegain:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn:");
    if (textField == emailTextField){
        [passwordTextField becomeFirstResponder];
    }
    else{
        [passwordTextField resignFirstResponder];
    }
    return YES;
}

@end
