//
//  TabBarButton.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//  tabBar上的按钮

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

// 创建tabButton
+(instancetype)tabButtonWithNormalIcon:(NSString *)normalIcon title:(NSString *)title target:(id)target action:(SEL)action;

@end
