//
//  HCSLogInViewController.h
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)dismissLogin;

@end

@interface LogInViewController : UIViewController

@property (nonatomic, weak) id <LoginViewDelegate> delegate;

- (id)initWithImage:(UIImage *)newImage;

@end
