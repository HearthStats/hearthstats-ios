//
//  HCSAppDelegate.m
//  hearthstats
//
//  Created by Paul Tower on 4/25/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "AppDelegate.h"
#import "DashboardViewController.h"
#import "ArenaViewController.h"
#import "ConstructedViewController.h"
#import "SettingsViewController.h"
#import "SVProgressHUD.h"
#import "CredentialStore.h"
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIColor *tintColor = [UIColor colorWithRed:0.949f green:0.455f blue:0.192f alpha:1.000];
    [self.window setTintColor:tintColor];
    
    kBaseURL = @"http://beta.hearthstats.net";
    
    [Crashlytics startWithAPIKey:@"33a7a0d865f1f5ad096f48493e2916bd878e2ec6"];
    
    CredentialStore *credStore = [[CredentialStore alloc] init];
    [credStore clearSavedCredentials];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    if (![preferences objectForKey:kPreferenceRemember]) {
        [preferences setInteger:0 forKey:kPreferenceRemember];
        [preferences synchronize];
    }
    
    [[UISwitch appearance] setOnTintColor:tintColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:kDefaultFont size:10]}
                                             forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:kDefaultFont size:13]}
                                                   forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:kDefaultFont size:20]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:kDefaultFont size:18]}
                                                forState:UIControlStateNormal];
    
    DashboardViewController *firstVC = [[DashboardViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    ArenaViewController *secondVC = [[ArenaViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    ConstructedViewController *thirdVC = [[ConstructedViewController alloc] init];
    UINavigationController *thirdNav = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    SettingsViewController *fourthVC = [[SettingsViewController alloc] init];
    UINavigationController *fourthNav = [[UINavigationController alloc] initWithRootViewController:fourthVC];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.200f alpha:1.000]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    [tabBar setViewControllers:@[firstNav, secondNav, thirdNav, fourthNav]];
    [self.window setRootViewController:tabBar];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Public Methods

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data Stack

- (void)saveContext {
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"hearthstats" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"hearthstats.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application Notifications

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
