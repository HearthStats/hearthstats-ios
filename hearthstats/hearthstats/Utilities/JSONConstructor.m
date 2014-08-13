//
//  HCSJSONConstructor.m
//  hearthstats
//
//  Created by Paul Tower on 5/10/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "JSONConstructor.h"

@implementation JSONConstructor

#pragma mark - Class Methods

+ (NSDictionary *)constructUserJSONWithEmail:(NSString *)email andPassword:(NSString *)password {
    
    return @{@"user_login":
                 @{@"email":email,
                   @"password":password}
             };
}

+ (NSDictionary *)constructRetrieveMatchJSONWithAuthToken:(NSString *)authToken {
    
    return @{@"auth_token": authToken,
             @"season" : @"6"};
}

@end
