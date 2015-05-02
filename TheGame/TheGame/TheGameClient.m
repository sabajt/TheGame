//
//  TheGameClient.m
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "TheGameClient.h"
#import "AFNetworking.h"

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

- (void)fetchUser:(NSString*)uid success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kBaseURLString];
    url = [[url URLByAppendingPathComponent:@"users"] URLByAppendingPathComponent:uid];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        success(operation, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure with error: %@", [error description]);
        failure(operation, error);
    }];
    
    [operation start];
}


@end
