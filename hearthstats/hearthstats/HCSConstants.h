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

@interface HCSConstants : NSObject

extern NSString *kBaseURL;
extern NSString *const kDefaultFont;
extern NSString *const kHearthStats;

extern NSString *const kPreferenceRemember;
extern NSString *const kPreferenceLastEmail;

extern NSString *const kLoggedInNotification;
extern NSString *const kLoggedInFailedNotification;
extern NSString *const kRetrieveMatchesNotification;
extern NSString *const kRetrieveMatchesFailedNotification;

@end
