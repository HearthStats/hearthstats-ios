//
//  HCSChangelogViewController.m
//  hearthstats
//
//  Created by Paul Tower on 7/15/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import "HCSChangelogViewController.h"

@interface HCSChangelogViewController ()

@end

@implementation HCSChangelogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = NSLocalizedString(@"Changelog", nil);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"changelog" ofType:@"txt"];
    NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    UITextView *text = [[UITextView alloc] init];
    text.font = [UIFont fontWithName:kDefaultFont size:14];
    text.text = myText;
    [text setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:text];
    
    id topGuide = [self topLayoutGuide];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[text]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(topGuide, text)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[text]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(text)]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
