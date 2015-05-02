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

@end
