//
//  CharacterClass.h
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterClass : NSObject

@property (nonatomic, copy) NSString* name;
@property NSNumber* classId;

+ (CharacterClass *)characterClassFromResponse:(NSDictionary*)response;

@end
