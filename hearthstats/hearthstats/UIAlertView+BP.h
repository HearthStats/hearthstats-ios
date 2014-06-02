//
//  UIAlertView+BP.h
//  piratewalla
//
//  Created by Kevin Lohman on 12/13/13.
//  Copyright (c) 2013 Kevin Lohman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (BP)
+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completionHandler:(void(^)(UIAlertView *alertView, NSUInteger buttonClicked))completionHandler;
@end
