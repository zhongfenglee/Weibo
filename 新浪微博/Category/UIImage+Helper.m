//
//  UIImage+Helper.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "UIImage+Helper.h"
#import "NSString+Helper.h"

@implementation UIImage (Helper)

#pragma mark - 加载全屏图片
+(UIImage *)fullScreenImage:(NSString *)imageName
{
    if (iPhone5oriPhone5s) {
        imageName = [imageName fileNameAppend:@"-568h@2x"];
    }
    
    if (iPhone6oriPhone6s) {
        imageName = [imageName fileNameAppend:@"-667h@2x"];
    }
    
    return [self imageNamed:imageName];
}

#pragma mark - 拉伸图片
+(UIImage *)stretchImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
