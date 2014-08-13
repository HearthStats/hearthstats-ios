//
//  HCSSessionManager.h
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface SessionManager : AFHTTPRequestOperationManager

+ (SessionManager *)sharedInstance;

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password;
- (void)retrieveMatchesForSeason:(NSNumber *)season;

@end
