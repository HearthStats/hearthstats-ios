//
//  HCSJSONConstructor.h
//  hearthstats
//
//  Created by Paul Tower on 5/10/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSJSONConstructor : NSObject

+ (NSDictionary *)constructUserJSONWithEmail:(NSString *)email andPassword:(NSString *)password;
+ (NSDictionary *)constructRetrieveMatchJSONWithAuthToken:(NSString *)authToken;

@end
