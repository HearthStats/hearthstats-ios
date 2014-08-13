//
//  HCSJSONConstructor.h
//  hearthstats
//
//  Created by Paul Tower on 5/10/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONConstructor : NSObject

+ (NSDictionary *)constructUserJSONWithEmail:(NSString *)email andPassword:(NSString *)password;
+ (NSDictionary *)constructMatchJSONWithAuthToken:(NSString *)authToken
                                          forMode:(MatchMode)mode
                                       withResult:(MatchResult)result
                                  withPlayerClass:(PlayerClass)playerClass
                                withOpponentClass:(PlayerClass)opponentClass
                                         withCoin:(NSNumber *)hasCoin
                                        forSeason:(NSNumber *)season
                                        forDeckID:(NSString *)deckID;

@end
