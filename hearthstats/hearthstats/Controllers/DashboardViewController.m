//
//  HCSDashboardViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "DashboardViewController.h"
#import "DashboardTableViewCell.h"
#import "LogInViewController.h"
#import "CredentialStore.h"
#import "SessionManager.h"
#import "SVProgressHUD.h"

@interface DashboardViewController () <UITableViewDataSource, UITableViewDelegate, LoginViewDelegate, UIAlertViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *rowArray;

@end

@implementation DashboardViewController

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
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"DashboardCell" bundle:nil] forCellReuseIdentifier:@"CellID"];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)]];
    [self.view addSubview:self.tableView];
    
    id topGuide = [self topLayoutGuide];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|"
                                                                      options:0
                                                                      metrics:0
                                                                        views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide][_tableView]|"
                                                                      options:0
                                                                      metrics:0
                                                                        views:NSDictionaryOfVariableBindings(topGuide, _tableView)]];
    
    self.rowArray = @[@"12.5%",
                      @"87.5%",
                      @"Party Time",
                      @"Warlock"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(matchesRetrieved:)
                                                 name:kRetrieveMatchesNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(matchesRetrievedFailed:)
                                                 name:kRetrieveMatchesFailedNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    CredentialStore *credStore = [[CredentialStore alloc] init];
    if (![credStore isLoggedIn]) {
        [self loggedOut];
    } else {
        [self retrieveMatches];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kRetrieveMatchesNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kRetrieveMatchesFailedNotification
                                                  object:nil];
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

- (void)loggedOut {
    
    LogInViewController *login = [[LogInViewController alloc] init];
    [login setDelegate:self];
    [self presentViewController:login
                       animated:YES
                     completion:nil];
}

- (void)retrieveMatches {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Retrieving Stats", nil)
                         maskType:SVProgressHUDMaskTypeClear];
    [[SessionManager sharedInstance] retrieveMatchesForSeason:@0];
}

- (void)matchesRetrieved:(NSNotification *)notification {
    
    [SVProgressHUD dismiss];
}

- (void)matchesRetrievedFailed:(NSNotification *)notification {
    
    [UIAlertView alertWithTitle:NSLocalizedString(@"Retrieval failed", nil)
                        message:nil // TODO: Parse and make readable error message from notification
              cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
              otherButtonTitles:@[NSLocalizedString(@"Retry", nil)]
              completionHandler:^(UIAlertView *alertView, NSUInteger buttonClicked) {
                  if(alertView.cancelButtonIndex == buttonClicked) return; // Do nothing
                  [self retrieveMatches];
              }];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 10 && buttonIndex == 1) {
        CredentialStore *credStore = [[CredentialStore alloc] init];
        [credStore clearSavedCredentials];
        [self loggedOut];
    }
}

#pragma mark - Log In Delegate

- (void) dismissLogin {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self retrieveMatches];
    }];
}

#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.rowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellID";
    DashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DashboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    UIColor *bgColor;
    UIImage *icon;
    NSString *subtitle;
    switch (indexPath.row) {
        case 0:
            bgColor = [UIColor colorWithRed:0.192f green:0.667f blue:0.882f alpha:1.000];
            icon = [UIImage imageNamed:@"ArenaDashboard"];
            subtitle = NSLocalizedString(@"Arena Win Rate", nil);
            break;
        case 1:
            bgColor = [UIColor colorWithRed:0.196f green:0.733f blue:0.463f alpha:1.000];
            icon = [UIImage imageNamed:@"ConstructedDashboard"];
            subtitle = NSLocalizedString(@"Ranked Win Rate", nil);
            break;
        case 2:
            bgColor = [UIColor colorWithRed:0.518f green:0.192f blue:0.592f alpha:1.000];
            icon = [UIImage imageNamed:@"DeckDashboard"];
            subtitle = NSLocalizedString(@"Best Deck", nil);
            break;
        case 3:
            bgColor = [UIColor colorWithRed:0.427f green:0.800f blue:0.933f alpha:1.000];
            icon = [UIImage imageNamed:@"ArenaClassDashboard"];
            subtitle = NSLocalizedString(@"Best Arena Class", nil);
            break;
        default:
            bgColor = [UIColor whiteColor];
            break;
    }
    cell.backgroundColor = bgColor;
    cell.icon.image = icon;
    cell.subtitle.text = subtitle;
    cell.title.text = self.rowArray[indexPath.row];
    
    cell.userInteractionEnabled = NO;
    
    return cell;
}

@end
