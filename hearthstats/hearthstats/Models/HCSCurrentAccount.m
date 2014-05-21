//
//  HCSCurrentAccount.m
//  hearthstats
//
//  Created by Paul Tower on 5/21/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSCurrentAccount.h"

@implementation HCSCurrentAccount

+ (HCSCurrentAccount *)sharedInstance {
    
    static HCSCurrentAccount *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HCSCurrentAccount alloc] init];
    });
    
    return _sharedInstance;
}

@end
