//
//  HCSDashboardViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSDashboardViewController.h"

@interface HCSDashboardViewController ()

@end

@implementation HCSDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setTitle:NSLocalizedString(@"Dashboard", nil)];
        [self.tabBarItem setImage:[UIImage imageNamed:@"DashboardIcon"]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Dashboard", nil);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Log out", nil)
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(logOut)];
    [self.navigationItem setRightBarButtonItem:rightButton];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SwipeSimple"
                                                    message:NSLocalizedString(@"Log out?", nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"Log out", nil), nil];
    [alert setTag:10];
    [alert show];
}

@end
