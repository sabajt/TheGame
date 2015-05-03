//
//  CharactersViewController.m
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "CharactersViewController.h"
#import "TheGameClient.h"
#import "Character.h"

@interface CharactersViewController ()

@end

@implementation CharactersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[TheGameClient sharedInstance] fetchCharacters:self.user success:^(NSArray *characters) {
        
        NSLog(@"success fetching characters: %@", characters);
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure fetching characters: %@", [error description]);
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
