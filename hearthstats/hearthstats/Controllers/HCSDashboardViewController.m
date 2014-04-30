//
//  HCSDashboardViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSDashboardViewController.h"
#import "HCSDashboardTableViewCell.h"
#import "NSString+FontAwesome.h"

@interface HCSDashboardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *rowArray;

@end

@implementation HCSDashboardViewController

#pragma mark - Init Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Dashboard", nil);
        [self.tabBarItem setTitle:NSLocalizedString(@"Dashboard", nil)];
        [self.tabBarItem setImage:[UIImage imageNamed:@"DashboardIcon"]];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Log out", nil)
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(logOut)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView registerNib:[UINib nibWithNibName:@"HCSDashboardCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    
    _rowArray = @[@"12.5%",
                  @"87.5%",
                  @"Party Time",
                  @"Warlock"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)logOut {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"HearthStats", nil)
                                                    message:NSLocalizedString(@"Log out?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"Log out", nil), nil];
    [alert setTag:10];
    [alert show];
}

#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_rowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellID";
    HCSDashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HCSDashboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    UIColor *bgColor;
    UIImage *icon;
    NSString *iconLabel;
    switch (indexPath.row) {
        case 0:
            bgColor = [UIColor colorWithRed:0.192f green:0.667f blue:0.882f alpha:1.000];
            icon = [UIImage imageNamed:@"ArenaDashboard"];
            break;
        case 1:
            bgColor = [UIColor colorWithRed:0.196f green:0.733f blue:0.463f alpha:1.000];
            icon = [UIImage imageNamed:@"ConstructedDashboard"];
            break;
        case 2:
            bgColor = [UIColor colorWithRed:0.518f green:0.192f blue:0.592f alpha:1.000];
            iconLabel = [NSString fontAwesomeIconStringForEnum:FAGlobe];
            break;
        case 3:
            bgColor = [UIColor colorWithRed:0.427f green:0.800f blue:0.933f alpha:1.000];
            iconLabel = [NSString fontAwesomeIconStringForEnum:FABarChartO];
            break;
        default:
            bgColor = [UIColor whiteColor];
            break;
    }
    cell.backgroundColor = bgColor;
    cell.icon.image = icon;
    
    cell.iconLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:48];
    cell.iconLabel.textColor = [UIColor whiteColor];
    cell.iconLabel.textAlignment = NSTextAlignmentCenter;
    cell.iconLabel.text = iconLabel;
    
    return cell;
}

@end
