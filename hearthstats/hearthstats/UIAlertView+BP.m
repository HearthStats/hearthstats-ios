//
//  UIAlertView+BP.m
//  piratewalla
//
//  Created by Kevin Lohman on 12/13/13.
//  Copyright (c) 2013 Kevin Lohman. All rights reserved.
//

#import "UIAlertView+BP.h"

@interface UIAlertView_block : UIAlertView <UIAlertViewDelegate>
@property (nonatomic, copy) void(^completionHandler)(UIAlertView *alertView, NSUInteger buttonClicked);
@end

@implementation UIAlertView (BP)
+ (id)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completionHandler:(void(^)(UIAlertView *alertView, NSUInteger buttonClicked))completionHandler
{
    if(![NSThread isMainThread]) // addButtonWithTitle is not threadsafe, threadsafe this method too.
    {
        id __block result = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            result = [self alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles completionHandler:completionHandler];
        });
        return result;
    }
    
    UIAlertView_block *alert = [[UIAlertView_block alloc] initWithTitle:title
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:cancelButtonTitle
                                                      otherButtonTitles:nil];
    alert.delegate = alert;
    alert.completionHandler = completionHandler;
    for(NSString *buttonString in otherButtonTitles)
        [alert addButtonWithTitle:buttonString];
    return alert;
}
@end

@implementation UIAlertView_block
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.completionHandler) self.completionHandler(alertView,buttonIndex);
}

// Threadsafe show
- (void)show
{
    if(![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:_cmd withObject:nil waitUntilDone:NO];
        return;
    }
    [super show];
}
@end