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
    NSString* name = response[@"name"];
    NSNumber* level = response[@"level"];
    NSNumber* classId = response[@"class_id"];
    NSNumber* userID = response[@"user_id"];
    
    Character* character = [[Character alloc] init];
    character.name = name;
    character.level = [level integerValue];
    character.classId = [classId integerValue];
    character.userId = [userID integerValue];
    
    return character;
}

@end
