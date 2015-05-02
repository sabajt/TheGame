//
//  PlayerViewController.m
//  TheGame
//
//  Created by John Saba on 5/2/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "PlayerViewController.h"
#import "TheGameClient.h"

@interface PlayerViewController ()

@property (copy, nonatomic) NSString* uid;
@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.uid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.uidLabel.text = self.uid;
    
    [[TheGameClient sharedInstance] fetchUser:self.uid success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // success
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
