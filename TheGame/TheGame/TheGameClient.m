//
//  TheGameClient.m
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "TheGameClient.h"
#import "AFNetworking.h"
#import "User.h"
#import "Character.h"
#import "CharacterClass.h"

static NSString* const kBaseURLString = @"https://location-game.herokuapp.com/api/";

@implementation TheGameClient

+ (TheGameClient*)sharedInstance
{
    static TheGameClient* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[TheGameClient alloc] init];
    });
    return instance;
}

- (void)fetchUser:(NSString*)uid success:(void (^)(User* user))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    url = [[url URLByAppendingPathComponent:@"users"] URLByAppendingPathComponent:uid];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        
        // user found
        if (responseObject[@"data"] != [NSNull null])
        {
            User* user = [User userFromResponse:responseObject];
            success(user);
        }
        // no user found
        else
        {
            success(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(error);
    }];
    
    [operation start];
}

- (void)createUser:(NSString*)uid name:(NSString*)name success:(void (^)(User* user))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSDictionary* params = @{@"user" : @{@"name" : name, @"key" : uid}};
    
    [manager POST:@"users" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"create user response: %@", responseObject);
        User* user = [User userFromResponse:responseObject];
        success(user);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(error);
    }];
}

- (void)fetchCharacters:(User*)user success:(void (^)(NSArray* characters))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    url = [[url URLByAppendingPathComponent:@"users"] URLByAppendingPathComponent:user.uid];
    url = [url URLByAppendingPathComponent:@"characters"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        
        // characters found
        if (responseObject[@"data"] != [NSNull null])
        {
            NSMutableArray* characters = [NSMutableArray array];
            for (NSDictionary* response in responseObject[@"data"])
            {
                Character* character = [Character characterFromResponse:response];
                [characters addObject:character];
            }
            success(characters);
        }
        // no characters found
        else
        {
            success(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(error);
    }];
    
    [operation start];
}

- (void)createCharacterNamed:(NSString*)name uid:(NSString*)uid level:(NSNumber*)level classsId:(NSNumber*)classId success:(void (^)(Character* character))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSDictionary* params = @{@"character" : @{@"name" : name, @"user_id" : uid, @"level" : level, @"class_id" : classId}};
    NSString* path = [[@"users" stringByAppendingPathComponent:uid] stringByAppendingPathComponent:@"characters"];
    
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"create character response: %@", responseObject);
        Character* character = [Character characterFromResponse:responseObject];
        success(character);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(error);
    }];
}

- (void)fetchClassesWithSuccess:(void (^)(NSArray* classes))success failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    url = [url URLByAppendingPathComponent:@"classes"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        
        // classes found
        if (responseObject[@"data"] != [NSNull null])
        {
            NSMutableArray* classes = [NSMutableArray array];
            for (NSDictionary* response in responseObject[@"data"])
            {
                CharacterClass* chClass = [CharacterClass characterClassFromResponse:response];
                [classes addObject:chClass];
            }
            success(classes);
        }
        // no classes found
        else
        {
            success(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(error);
    }];
    
    [operation start];
}


@end
