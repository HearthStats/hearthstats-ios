//
//  UIColor+ColorWithHexAndAlpha.h
//  Shelby.tv
//
//  Created by Arthur Ariel Sabintsev on 1/21/13.
//  Copyright (c) 2013 Arthur Ariel Sabintsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorWithHexAndAlpha)

+ (instancetype)colorWithHex:(NSString*)hex andAlpha:(CGFloat)alpha;

@end