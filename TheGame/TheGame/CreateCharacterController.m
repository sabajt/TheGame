//
//  CreateCharacterController.m
//  TheGame
//
//  Created by John Saba on 5/3/15.
//  Copyright (c) 2015 John Saba. All rights reserved.
//

#import "CreateCharacterController.h"
#import "TheGameClient.h"
#import "User.h"
#import "CharacterClass.h"

@interface CreateCharacterController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *classes;
@property (copy, nonatomic) NSNumber* selectedId;

@end

@implementation CreateCharacterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.classes = [NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    [[TheGameClient sharedInstance] fetchClassesWithSuccess:^(NSArray *classes) {
        self.classes = classes;
        [self.tableView reloadData];
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        CharacterClass* chClass = self.classes[indexPath.row];
        self.selectedId = chClass.classId;
        
    } failure:^(NSError *error) {
        NSLog(@"failure fetching classes: %@", error.description);
    }];
}

- (IBAction)doItButtonPressed:(id)sender
{
    NSString* name = self.nameField.text;
    if (name.length < 1)
    {
        return;
    }
    
    [[TheGameClient sharedInstance] createCharacterNamed:name uid:self.user.uid level:@1 classsId:self.selectedId success:^(Character *character) {
        NSLog(@"successfully created character: %@", character);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to create character; %@", [error description]);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.classes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CharacterClass* chClass = self.classes[indexPath.row];
    cell.textLabel.text = chClass.name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterClass* chClass = self.classes[indexPath.row];
    self.selectedId = chClass.classId;
}

@end
