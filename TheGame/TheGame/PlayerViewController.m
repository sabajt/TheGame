//
//  PlayerViewController.m
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "PlayerViewController.h"
#import "TheGameClient.h"
#import "User.h"

@interface PlayerViewController ()

@property (copy, nonatomic) NSString* uid;
@property (strong, nonatomic) User* user;

@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *createUserButton;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.uid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.uidLabel.text = self.uid;
    self.statusLabel.text = @"Making network request...";
    self.nameField.hidden = YES;
    self.createUserButton.hidden = YES;
    
    [[TheGameClient sharedInstance] fetchUser:self.uid success:^(User *user) {
        if (user)
        {
            self.user = user;
            self.statusLabel.text = [NSString stringWithFormat:@"Found User: %@", user.name];
        }
        else
        {
            self.statusLabel.text = @"No user associated with device, please create one!";
            self.nameField.hidden = NO;
            self.createUserButton.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        self.statusLabel.text = @"Failure to reach network";
    }];
}

- (IBAction)createUserPressed:(UIButton *)sender
{
    NSString* name =  self.nameField.text;
    if (!name || name.length < 1)
    {
        return;
    }
    
    [[TheGameClient sharedInstance] createUser:self.uid name:name success:^(User *user) {
        self.user = user;
        self.statusLabel.text = [NSString stringWithFormat:@"Created new user: %@", user.name];
        self.nameField.hidden = YES;
        self.createUserButton.hidden = YES;
        
    } failure:^(NSError *error) {
        self.statusLabel.text = @"Failure to create user";
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
