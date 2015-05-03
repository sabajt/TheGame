//
//  CharacterClass.m
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "CharacterClass.h"

@implementation CharacterClass

+ (CharacterClass *)characterClassFromResponse:(NSDictionary *)response
{
    NSString* name = response[@"name"];
    NSNumber* classId = response[@"id"];
    
    CharacterClass* characterClass = [[CharacterClass alloc] init];
    characterClass.name = name;
    characterClass.classId = classId;
    
    return characterClass;
}


@end
