//
//  HCSLogInViewController.h
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCSLoginViewDelegate <NSObject>

- (void)dismissLogin;

@end

@interface LogInViewController : UIViewController

@property (nonatomic, weak) id <HCSLoginViewDelegate> delegate;

- (id)initWithImage:(UIImage *)newImage;

@end
