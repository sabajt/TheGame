//
//  User.m
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)userFromResponse:(NSDictionary*)response
{
    NSDictionary* data = response[@"data"];
    NSString* name = data[@"name"];
    NSString* uid = data[@"key"];
    
    User* user = [[User alloc] init];
    user.name = name;
    user.uid = uid;
    
    return user;
}

@end
