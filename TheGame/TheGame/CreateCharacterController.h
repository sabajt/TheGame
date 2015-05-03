//
//  CreateCharacterController.h
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface CreateCharacterController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) User* user;

@end
