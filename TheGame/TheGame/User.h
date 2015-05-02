//
//  User.h
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* uid;

+ (User *)userFromResponse:(NSDictionary*)response;

@end
