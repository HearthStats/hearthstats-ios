//
//  HCSLogInViewController.m
//  hearthstats
//
//  Created by Paul Tower on 4/30/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSLogInViewController.h"
#import "HCSSessionManager.h"
#import "SVProgressHUD.h"

@interface HCSLogInViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic) UIImage *bgImage;
@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIButton *logInButton;

@end

@implementation HCSLogInViewController

#pragma mark - Init Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImage:(UIImage *)newImage {
    
    self = [super init];
    if (self) {
        _bgImage = newImage;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_bgImageView setImage:_bgImage];
    
    [_emailField setDelegate:self];
    [_emailField setTag:10];
	[_emailField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)]];
    [_emailField setLeftViewMode:UITextFieldViewModeAlways];
    [_passwordField setDelegate:self];
    [_passwordField setTag:20];
    [_passwordField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)]];
    [_passwordField setLeftViewMode:UITextFieldViewModeAlways];
    
    [_logInButton addTarget:self
                     action:@selector(logInButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismissKeyboard)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setDelegate:self];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loggedIn)
                                                 name:kLoggedInNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissHUD)
                                                 name:kLoggedInFailedNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLoggedInNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLoggedInFailedNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)logInButtonPressed:(UIButton *)sender {
    
    [self logIn];
}

- (void)logIn {
    
    NSString *errorMessage = nil;
    if ([_emailField.text isEqualToString:@""]) {
        errorMessage = NSLocalizedString(@"Email cannot be blank", nil);
    } else if ([_passwordField.text isEqualToString:@""]) {
        errorMessage = NSLocalizedString(@"Password cannot be blank", nil);
    }
    
    if (errorMessage) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SwipeSimple"
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeClear];
        [[HCSSessionManager sharedInstance] loginWithEmail:_emailField.text andPassword:_passwordField.text];
    }
}

- (void)loggedIn {
    
    [SVProgressHUD showSuccessWithStatus:@"Success"];
    [self dismissKeyboard];
    if ([_delegate respondsToSelector:@selector(dismissLogin)]) {
        [_delegate dismissLogin];
    }
}

- (void)dismissHUD {
    
    [SVProgressHUD dismiss];
}

- (void)dismissKeyboard {
    
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 10) {
        [_passwordField becomeFirstResponder];
        return NO;
    }
    
    if (textField.tag == 20) {
        [self logIn];
        return YES;
    }
    
    return YES;
}

@end
