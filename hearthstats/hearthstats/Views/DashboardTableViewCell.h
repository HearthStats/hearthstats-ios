//
//  HCSDashboardTableViewCell.h
//  hearthstats
//
//  Created by Paul Tower on 4/29/14.
//  Copyright (c) 2014 Hypercube Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subtitle;

@end
