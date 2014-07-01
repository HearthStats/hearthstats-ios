//
//  HCSConstants.h
//  hearthstats
//
//  Created by Paul Tower on 4/28/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PlayerClass {
    NONE,
    DRUID,
    HUNTER,
    MAGE,
    PALADIN,
    PRIEST,
    ROGUE,
    SHAMAN,
    WARLOCK,
    WARRIOR
} PlayerClass;

typedef enum MatchResult {
    UNKNOWN,
    VICTORY,
    DEFEAT,
    DRAW
} MatchResult;

FOUNDATION_EXPORT NSString * kBaseURL;
FOUNDATION_EXPORT NSString * const kDefaultFont;
FOUNDATION_EXPORT NSString * const kHearthStats;
FOUNDATION_EXPORT NSString * const kPreferenceRemember;
FOUNDATION_EXPORT NSString * const kPreferenceLastEmail;
FOUNDATION_EXPORT NSString * const kLoggedInNotification;
FOUNDATION_EXPORT NSString * const kLoggedInFailedNotification;
FOUNDATION_EXPORT NSString * const kRetrieveMatchesNotification;
FOUNDATION_EXPORT NSString * const kRetrieveMatchesFailedNotification;

@interface HCSConstants : NSObject


@end
