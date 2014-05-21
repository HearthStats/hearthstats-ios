//
//  HCSCurrentAccount.h
//  hearthstats
//
//  Created by Paul Tower on 5/21/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSCurrentAccount : NSObject

@property (nonatomic) NSString *email;
@property (nonatomic) NSArray *matches;

+ (HCSCurrentAccount *)sharedInstance;

@end
