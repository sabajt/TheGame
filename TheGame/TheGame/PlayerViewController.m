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
@property (weak, nonatomic) IBOutlet UIButton *charactersButton;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.uid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.uidLabel.text = self.uid;
    self.statusLabel.text = @"Attempting to fetch user...";
    self.nameField.hidden = YES;
    self.createUserButton.hidden = YES;
    self.nameField.delegate = self;
    self.charactersButton.hidden = YES;
    
    [[TheGameClient sharedInstance] fetchUser:self.uid success:^(User *user) {
        if (user)
        {
            self.user = user;
            self.statusLabel.text = [NSString stringWithFormat:@"Found User: %@", user.name];
            self.charactersButton.hidden = NO;
        }
        else
        {
            self.statusLabel.text = @"No user associated with device, please create one!";
            self.nameField.hidden = NO;
            self.createUserButton.hidden = NO;
            self.charactersButton.hidden = YES;
        }
        
    } failure:^(NSError *error) {
        self.statusLabel.text = @"Failure to reach network";
    }];
}

#pragma mark - IB Callbacks

- (IBAction)createUserPressed:(UIButton *)sender
{
    NSString* name =  self.nameField.text;
    if (!name || name.length < 1)
    {
        self.statusLabel.text = @"Please enter user name";
        return;
    }
    
    self.statusLabel.text = @"Attempting to create user...";
    
    [[TheGameClient sharedInstance] createUser:self.uid name:name success:^(User *user) {
        self.user = user;
        self.statusLabel.text = [NSString stringWithFormat:@"Created new user: %@", user.name];
        self.nameField.hidden = YES;
        self.createUserButton.hidden = YES;
        self.charactersButton.hidden = NO;
        
    } failure:^(NSError *error) {
        self.statusLabel.text = @"Failure to create user";
        self.charactersButton.hidden = YES;
    }];
}

- (IBAction)charactersButtonPressed:(id)sender
{
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
