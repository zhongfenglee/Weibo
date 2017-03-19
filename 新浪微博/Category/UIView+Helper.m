//
//  UIView+Helper.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/8/15.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
