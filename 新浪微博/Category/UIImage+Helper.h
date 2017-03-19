//
//  UIImage+Helper.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

// 加载全屏图片
+(UIImage *)fullScreenImage:(NSString *)imageName;

// 剪切图片
+(UIImage *)stretchImageWithImageName:(NSString *)imageName;

@end
