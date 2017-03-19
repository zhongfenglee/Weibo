//
//  UIButton+Helper.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)

+(UIButton *)buttonWithBackgroundImage:(NSString *)backgroundImageName title:(NSString *)title target:(id)target action:(SEL)action;

+(UIButton *)buttonWithImage:(NSString *)imageName selectedImageNameAppend:(NSString *)selectedImageNameAppend highlightedImageNameAppend:(NSString *)highlightedImageNameAppend backgroundImageName:(NSString *)backgroundImageName highlightedBgImageNameAppend:(NSString *)highlightedBgImageNameAppend selectedBgImageNameAppend:(NSString *)selectedBgImageNameAppend title:(NSString *)title target:(id)target action:(SEL)action;

@end
