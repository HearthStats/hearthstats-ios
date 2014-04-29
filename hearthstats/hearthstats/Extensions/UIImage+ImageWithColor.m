//
//  UIImage+ImageWithColor.m
//  SwipeSimple
//
//  Created by Paul Tower on 1/23/14.
//  Copyright (c) 2014 CardFlight. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
