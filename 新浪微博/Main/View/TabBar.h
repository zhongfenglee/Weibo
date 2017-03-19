//
//  TabBar.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//  tabBar

#import <UIKit/UIKit.h>
#import "Singleton.h"

@class TabBarButton;

@interface TabBar : UIView

single_interface(TabBar)

// 创建tabBarButton（该方法再去调用TabBarButton.h中的+(instancetype)tabButtonWithNormalIcon:(NSString *)normalIcon title:(NSString *)title target:(id)target action:(SEL)action）
-(void)addTabBarButtonWithNormalIcon:(NSString *)normalIcon title:(NSString *)title;

@property (nonatomic,copy) void(^tabBarButtonDidSelectBlock)(NSUInteger from, NSUInteger to);

-(void)tabBarButtonDidSelect:(TabBarButton *)tabBarButton;

@end
