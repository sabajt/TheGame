//
//  Character.m
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (Character *)characterFromResponse:(NSDictionary *)response
{
    NSDictionary* data = response[@"data"];
    
    NSString* name = data[@"name"];
    NSNumber* level = data[@"level"];
    NSNumber* classId = data[@"class_id"];
    NSNumber* userID = data[@"user_id"];
    
    Character* character = [[Character alloc] init];
    character.name = name;
    character.level = [level integerValue];
    character.classId = [classId integerValue];
    character.userId = [userID integerValue];
    
    return character;
}

@end
