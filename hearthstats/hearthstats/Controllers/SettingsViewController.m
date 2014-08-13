//
//  HCSSettingsViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "SettingsViewController.h"
#import "ChangelogViewController.h"

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *rowArray;
@property (nonatomic) NSArray *sectionArray;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", nil);
        [self.tabBarItem setTitle:NSLocalizedString(@"Settings", nil)];
        [self.tabBarItem setImage:[UIImage imageNamed:@"SettingsIcon"]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.sectionArray = @[@"About"];
    self.rowArray = @[@[@{@"title": @"HearthStats",
                          @"value": [NSString stringWithFormat:NSLocalizedString(@"Version %@ Build %@", nil),
                                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]},
                        @{@"title": @"Changelog"}]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.rowArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *aboutCellID = @"AboutCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:aboutCellID];
    }
    if ([[self.rowArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"]) {
        [cell.detailTextLabel setFont:[UIFont fontWithName:kDefaultFont size:16]];
        [cell.detailTextLabel setText:[[self.rowArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"]];
    }
    
    [cell.textLabel setFont:[UIFont fontWithName:kDefaultFont size:16]];
    [cell.textLabel setText:[[self.rowArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    BOOL userInteraction;
    UITableViewCellAccessoryType accessory;
    
    switch (indexPath.section) {
        case 0: {
            // About Section
            switch (indexPath.row) {
                case 0:
                    // Version Info
                    userInteraction = NO;
                    accessory = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    // Changelog
                    userInteraction = YES;
                    accessory = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            userInteraction = YES;
            accessory = UITableViewCellAccessoryDisclosureIndicator;
            break;
    }
    
    [cell setUserInteractionEnabled:userInteraction];
    [cell setAccessoryType:accessory];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *view;
    
    switch (indexPath.section) {
        case 0: {
            // About Section
            switch (indexPath.row) {
                case 0:
                    // Version Info
                    view = nil;
                    break;
                case 1:
                    // Changelog
                    view = [[ChangelogViewController alloc] init];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            view = nil;
            break;
    }
    
    if (view) {
        [view setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:view animated:YES];
    }
}

@end
