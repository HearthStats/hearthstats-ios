//
//  HCSSettingsViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSSettingsViewController.h"

@interface HCSSettingsViewController ()

@end

@implementation HCSSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setTitle:NSLocalizedString(@"Settings", nil)];
        [self.tabBarItem setImage:[UIImage imageNamed:@"SettingsIcon"]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
