//
//  HCSSettingsViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSSettingsViewController.h"

@interface HCSSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *rowArray;
@property (nonatomic) NSArray *sectionArray;

@end

@implementation HCSSettingsViewController

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
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    
    _sectionArray = @[@"About"];
    _rowArray = @[@[@{@"title": @"HearthStats",
                      @"value": [NSString stringWithFormat:NSLocalizedString(@"Version %@ Build %@", nil),
                                 [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                 [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]}]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_sectionArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _sectionArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_rowArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *aboutCellID = @"AboutCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:aboutCellID];
    }
    [cell.detailTextLabel setFont:[UIFont fontWithName:kDefaultFont size:16]];
    [cell.detailTextLabel setText:[[_rowArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"]];
    
    [cell.textLabel setFont:[UIFont fontWithName:kDefaultFont size:16]];
    [cell.textLabel setText:[[_rowArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    [cell setUserInteractionEnabled:NO];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    return cell;
}

@end
