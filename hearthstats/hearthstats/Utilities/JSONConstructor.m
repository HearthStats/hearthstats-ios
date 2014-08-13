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

+ (NSDictionary *)constructMatchJSONWithAuthToken:(NSString *)authToken
                                          forMode:(MatchMode)mode
                                       withResult:(MatchResult)result
                                  withPlayerClass:(PlayerClass)playerClass
                                withOpponentClass:(PlayerClass)opponentClass
                                         withCoin:(NSNumber *)hasCoin
                                        forSeason:(NSNumber *)season
                                        forDeckID:(NSString *)deckID {
    
    return @{@"auth_token":authToken ? authToken : [NSNull null],
             @"mode":mode ? [NSString stringWithFormat:@"%tu", mode] : [NSNull null],
             @"result":result ? [NSString stringWithFormat:@"%tu", result] : [NSNull null],
             @"klass":playerClass ? [NSString stringWithFormat:@"%tu", playerClass] : [NSNull null],
             @"oppclass":opponentClass ? [NSString stringWithFormat:@"%tu", opponentClass] : [NSNull null],
             @"coin":hasCoin ? hasCoin : [NSNull null],
             @"season":season ? [season stringValue] : [NSNull null],
             @"deck_id":deckID ? deckID : [NSNull null]};
}

@end
