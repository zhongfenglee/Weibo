//
//  CALayer+Helper.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/7/25.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "CALayer+Helper.h"

@implementation CALayer (Helper)

-(void)layerWithShadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius
{
    self.shadowColor = shadowColor.CGColor;
    self.shadowOpacity = shadowOpacity;
    self.shadowOffset = shadowOffset;
    self.shadowRadius = shadowRadius;
}

@end
