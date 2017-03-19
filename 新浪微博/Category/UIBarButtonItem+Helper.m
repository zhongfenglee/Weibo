//
//  UIBarButtonItem+Helper.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"
#import "UIButton+Helper.h"


@implementation UIBarButtonItem (Helper)

#pragma mark - 创建UIBarButtonItem
+(UIBarButtonItem *)barButtonItemWithNormalBackgroundImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action
{    
//    [button setBackgroundImage:normalBgImage forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:[normalBackgroundImage fileNameAppend:@"_highlighted"] ] forState:UIControlStateHighlighted];
    UIButton *button = [UIButton buttonWithBackgroundImage:imageName title:title target:target action:action];
//    button.bounds =(CGRect){CGPointZero,bgImageSize};
    
    return [[self alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)barButtonItemWithNormalBackgroundImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [self barButtonItemWithNormalBackgroundImage:imageName title:nil target:target action:action];
}

@end
