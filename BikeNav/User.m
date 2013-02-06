//
//  User.m
//  BikeNav
//
//  Created by Russell Wyatt on 2/4/13.
//  Copyright (c) 2013 Russell Wyatt. All rights reserved.
//

#import "User.h"

@implementation User

//Synthesize Data Objects
@synthesize userSettings, userHistory, userRide;

//Synthesize User info
@synthesize userName, userEmail;


//Initializers
-(id) init{
    if (!(self = [super init]))
        return nil;
    else
        return self;
}

-(id) initWithUserName:(NSString *)name andEmail:(NSString *)email{
    if (self = [super init]){
        userName = name;
        userEmail = email;
    }
    return self;
}

-(id) initWithSettings:(Settings *)loadedSettings
            andHistory:(History *)loadedHistory
            andRide:(Ride *)loadedRide{
    
    if (!(self = [super init]))
        return nil;
    
    self.userSettings = loadedSettings;
    self.userHistory = loadedHistory;
    self.userRide = loadedRide;
    
    return self;
}



@end
