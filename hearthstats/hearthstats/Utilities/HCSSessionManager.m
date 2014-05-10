//
//  HCSSessionManager.m
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSSessionManager.h"
#import "HCSJSONConstructor.h"
#import "HCSCredentialStore.h"

@implementation HCSSessionManager

#pragma mark - Singleton Methods

+ (HCSSessionManager *)sharedInstance {
    
    static HCSSessionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HCSSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return _sharedInstance;
}

#pragma mark - Init Methods

- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password {
    
    [self POST:@"/api/v2/users/sign_in"
    parameters:[HCSJSONConstructor constructUserJSONWithEmail:email andPassword:password]
       success:^(AFHTTPRequestOperation *operation, id responseObject){
            DLog(@"%@", responseObject);
           HCSCredentialStore *credStore = [[HCSCredentialStore alloc] init];
           [credStore setAuthToken:responseObject[@"auth_token"]];
           [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotification object:nil];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           DLog(@"%@", error.description);
           [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInFailedNotification object:nil];
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SwipeSimple"
                                                           message:NSLocalizedString(@"Invalid user name or password", nil)
                                                          delegate:self
                                                 cancelButtonTitle:@"Okay"
                                                 otherButtonTitles:nil];
           [alert show];
       }];
}

@end