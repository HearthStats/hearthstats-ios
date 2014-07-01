//
//  NSObject+AutoLayout.m
//  ID.me
//
//  Created by Arthur Sabintsev on 5/28/14.
//  Copyright (c) 2014 ID.me, Inc. All rights reserved.
//

#import "UIView+AutoLayoutView.h"

@implementation UIView (AutoLayoutView)

+ (instancetype)newAutoLayoutView
{
    UIView *view = [[self alloc] init];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return view;
}

@end
