//
//  HCSCredentialStore.m
//  hearthstats
//
//  Created by Paul Tower on 5/10/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "CredentialStore.h"
#import "SSKeychain.h"

#define SERVICE_NAME @"AuthClient"
#define AUTH_TOKEN_KEY @"auth_token"

@implementation CredentialStore

- (BOOL)isLoggedIn {
    
    return [self authToken] != nil;
}

- (void)clearSavedCredentials {
    
    [self setAuthToken:nil];
}

- (NSString *)authToken {
    
    return [self secureValueForKey:AUTH_TOKEN_KEY];
}

- (void)setAuthToken:(NSString *)authToken {
    
    [self setSecureValue:authToken forKey:AUTH_TOKEN_KEY];
    // DLog(@"setAuthToken");
}

- (void)setSecureValue:(NSString *)value forKey:(NSString *)key {
    
    if (value) {
        [SSKeychain setPassword:value
                     forService:SERVICE_NAME
                        account:key];
    } else {
        [SSKeychain deletePasswordForService:SERVICE_NAME account:key];
    }
}

- (NSString *)secureValueForKey:(NSString *)key {
    
    return [SSKeychain passwordForService:SERVICE_NAME account:key];
}
@end
