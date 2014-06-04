//
//  HCSMatch.h
//  hearthstats
//
//  Created by Paul Tower on 5/21/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSMatch : NSObject

@property (nonatomic) BOOL hadCoin;
@property (nonatomic) NSDate *created;
@property (nonatomic) NSNumber *duration;
@property (nonatomic) NSString *matchID;
@property (nonatomic) PlayerClass player;
@property (nonatomic) PlayerClass opponent;
@property (nonatomic) NSNumber *numberOfTurns;
@property (nonatomic) NSString *opponentName;
@property (nonatomic) MatchResult result;
@property (nonatomic) NSNumber *seasonID;

@end
