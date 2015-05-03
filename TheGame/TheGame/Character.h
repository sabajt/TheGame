//
//  Character.h
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, copy) NSString* name;
@property NSInteger level;
@property NSInteger classId;
@property NSInteger userId;

+ (Character *)characterFromResponse:(NSDictionary*)response;

@end
