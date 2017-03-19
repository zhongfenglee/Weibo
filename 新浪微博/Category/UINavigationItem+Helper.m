//
//  UINavigationItem+Helper.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "UINavigationItem+Helper.h"

@implementation UINavigationItem (Helper)

#pragma mark - 设置导航栏上的各个UINavigationItem、title、titleView
-(void)copyNavigationItemFromOtherVCNavigationItem:(UINavigationItem *)navigationItem
{
    self.leftBarButtonItem = navigationItem.leftBarButtonItem;
    self.rightBarButtonItem = navigationItem.rightBarButtonItem;
    
    self.leftBarButtonItems = navigationItem.leftBarButtonItems;
    self.rightBarButtonItems = navigationItem.rightBarButtonItems;
    
    self.titleView = navigationItem.titleView;
    
    self.title = navigationItem.title;
}

@end
