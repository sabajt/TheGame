//
//  TheGameClient.h
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@class AFHTTPRequestOperation;
@class User;

@interface TheGameClient : NSObject

+ (TheGameClient*)sharedInstance;

- (void)fetchUser:(NSString*)uid success:(void (^)(User* user))success failure:(void (^)(NSError *error))failure;
- (void)createUser:(NSString*)uid name:(NSString*)name success:(void (^)(User* user))success failure:(void (^)(NSError *error))failure;
- (void)fetchCharacters:(User*)user success:(void (^)(NSArray* characters))success failure:(void (^)(NSError *error))failure;
- (void)createCharacterNamed:(NSString*)uid uid:(NSString*)uid level:(NSNumber*)level classsId:(NSNumber*)classId success:(void (^)(Character* character))success failure:(void (^)(NSError *error))failure;
- (void)fetchClassesWithSuccess:(void (^)(NSArray* classes))success failure:(void (^)(NSError *error))failure;


@end
