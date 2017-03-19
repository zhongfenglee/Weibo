//
//  UIBarButtonItem+Helper.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Helper)

+(UIBarButtonItem *)barButtonItemWithNormalBackgroundImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

+(UIBarButtonItem *)barButtonItemWithNormalBackgroundImage:(NSString *)imageName target:(id)target action:(SEL)action;

@end
