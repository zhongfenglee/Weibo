//
//  UIButton+Helper.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "UIButton+Helper.h"
#import "UIImage+Helper.h"
#import "NSString+Helper.h"

@implementation UIButton (Helper)

#pragma mark - 创建图片大小的button(背景图片、标题、方法、尺寸)
+(UIButton *)buttonWithBackgroundImage:(NSString *)backgroundImageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage stretchImageWithImageName:backgroundImageName];
    
    UIButton *button = [self buttonWithImage:nil selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:backgroundImageName highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:@"_selected" title:title target:target action:action];
    
    button.bounds = (CGRect){CGPointZero,normalImage.size};
    
//    return normalImage.size;
    return button;
}

#pragma mark - 创建一个button(图片、背景图片、标题、绑定方法)
+(UIButton *)buttonWithImage:(NSString *)imageName selectedImageNameAppend:(NSString *)selectedImageNameAppend highlightedImageNameAppend:(NSString *)highlightedImageNameAppend backgroundImageName:(NSString *)backgroundImageName highlightedBgImageNameAppend:(NSString *)highlightedBgImageNameAppend selectedBgImageNameAppend:(NSString *)selectedBgImageNameAppend title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    // 当按钮不可被点击时，不要调节图片（按钮不可被点击时，系统默认将背景图片调的比较透明）
    button.adjustsImageWhenDisabled = NO;
    
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        if (selectedImageNameAppend.length) {
            [button setImage:[UIImage imageNamed:[imageName fileNameAppend:selectedImageNameAppend]] forState:UIControlStateSelected];
        }
        
        if (highlightedImageNameAppend.length) {
            [button setImage:[UIImage imageNamed:[imageName fileNameAppend:highlightedImageNameAppend]] forState:UIControlStateHighlighted];
        }
    }
    
    if (backgroundImageName.length) {
        UIImage *normalBgImage = [UIImage stretchImageWithImageName:backgroundImageName];
        [button setBackgroundImage:normalBgImage forState:UIControlStateNormal];
        
        if (selectedBgImageNameAppend.length) {
            UIImage *selectedBgImage = [UIImage stretchImageWithImageName:[backgroundImageName fileNameAppend:selectedBgImageNameAppend]];
            [button setBackgroundImage:selectedBgImage forState:UIControlStateSelected];
        }
        
        if (highlightedBgImageNameAppend.length) {
            UIImage *highlightedBgImage = [UIImage stretchImageWithImageName:[backgroundImageName fileNameAppend:highlightedBgImageNameAppend]];
            [button setBackgroundImage:highlightedBgImage forState:UIControlStateHighlighted];
        }
    }
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (target || action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

@end
