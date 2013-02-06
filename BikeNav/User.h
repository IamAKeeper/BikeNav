//
//  User.h
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Ride.h"
#include "History.h"
#include "Settings.h"


@interface User : NSObject

//Data Objects belonging to User
@property Settings *userSettings;
@property History *userHistory;
@property Ride *userRide;

//User information
@property NSString *userName, *userEmail;


//Initializers
- (id) init;
- (id) initWithUserName: (NSString *) name andEmail: (NSString *) email;
- (id) initWithSettings: (Settings *) loadedSettings andHistory: (History *) loadedHistory
                                                     andRide: (User *) loadedRide;




@end
