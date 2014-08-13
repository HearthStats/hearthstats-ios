//
//  HCSSessionManager.m
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "SessionManager.h"
#import "JSONConstructor.h"
#import "CredentialStore.h"

@implementation SessionManager

#pragma mark - Singleton Methods

+ (SessionManager *)sharedInstance {
    
    static SessionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
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
    parameters:[JSONConstructor constructUserJSONWithEmail:email andPassword:password]
       success:^(AFHTTPRequestOperation *operation, id responseObject){
            DLog(@"%@", responseObject);
           CredentialStore *credStore = [[CredentialStore alloc] init];
           [credStore setAuthToken:responseObject[@"auth_token"]];
           [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInNotification object:nil];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           DLog(@"%@", error.description);
           [[NSNotificationCenter defaultCenter] postNotificationName:kLoggedInFailedNotification object:nil];
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kHearthStats
                                                           message:NSLocalizedString(@"Invalid user name or password", nil)
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                                                 otherButtonTitles:nil];
           [alert show];
       }];
}

- (void)retrieveMatchesForMode:(MatchMode)mode
                    withResult:(MatchResult)result
                     withClass:(PlayerClass)playerClass
             withOpponentClass:(PlayerClass)opponentClass
                      withCoin:(BOOL)hasCoin
                     forSeason:(NSNumber *)season
                     forDeckID:(NSString *)deckID {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    CredentialStore *credStore = [[CredentialStore alloc] init];
    [self GET:@"/api/v2/matches/query"
   parameters:[JSONConstructor constructRetrieveMatchJSONWithAuthToken:[credStore authToken]]
      success:^(AFHTTPRequestOperation *operation, id responseObject){
          DLog(@"%@", responseObject);
          [center postNotificationName:kRetrieveMatchesNotification object:nil userInfo:@{@"responseObject":responseObject}];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error){
          DLog(@"%@", error.description);
          [center postNotificationName:kRetrieveMatchesFailedNotification object:nil userInfo:@{@"error":error}];
      }];
}

@end
