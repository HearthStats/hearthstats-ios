//
//  HCSConstants.h
//  hearthstats
//
//  Created by Paul Tower on 4/28/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PlayerClass) {
    PlayerClassNone = 0,
    PlayerClassDruid,
    PlayerClassHunter,
    PlayerClassMage,
    PlayerClassPaladin,
    PlayerClassPriest,
    PlayerClassRogue,
    PlayerClassShaman,
    PlayerClassWarlock,
    PlayerClassWarrior
};

typedef NS_ENUM(NSUInteger, MatchResult) {
    MatchResultUnknown,
    MatchResultVictory,
    MatchResultDefeat,
    MatchResultDraw
};

typedef NS_ENUM(NSUInteger, MatchMode) {
    MatchModeNone = 0,
    MatchModeModeArena,
    MatchModeCasual,
    MatchModeRanked
};

FOUNDATION_EXPORT NSString * kBaseURL;
FOUNDATION_EXPORT NSString * const kDefaultFont;
FOUNDATION_EXPORT NSString * const kHearthStats;
FOUNDATION_EXPORT NSString * const kPreferenceRemember;
FOUNDATION_EXPORT NSString * const kPreferenceLastEmail;
FOUNDATION_EXPORT NSString * const kLoggedInNotification;
FOUNDATION_EXPORT NSString * const kLoggedInFailedNotification;
FOUNDATION_EXPORT NSString * const kRetrieveMatchesNotification;
FOUNDATION_EXPORT NSString * const kRetrieveMatchesFailedNotification;

@interface Constants : NSObject


@end
