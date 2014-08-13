//
//  HCSCurrentAccount.m
//  hearthstats
//
//  Created by Paul Tower on 5/21/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "CurrentAccount.h"

@implementation CurrentAccount

+ (CurrentAccount *)sharedInstance {
    
    static CurrentAccount *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CurrentAccount alloc] init];
    });
    
    return _sharedInstance;
}

@end
