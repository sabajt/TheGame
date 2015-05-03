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
#import "CreateCharacterController.h"

@interface CharactersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* characters;

@end

@implementation CharactersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [[TheGameClient sharedInstance] fetchCharacters:self.user success:^(NSArray *characters) {
        self.characters = [NSMutableArray arrayWithArray:characters];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"failure fetching characters: %@", [error description]);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Character* character = self.characters[indexPath.row];
    cell.textLabel.text = character.name;
    return cell;
}


#pragma mark - UITableViewDelegate


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreateCharacterController* vc = [segue destinationViewController];
    vc.user = self.user;
}


@end
