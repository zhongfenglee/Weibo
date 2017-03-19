//
//  CALayer+Helper.h
//  新浪微博
//
//  Created by zhongfeng1 on 16/7/25.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Helper)

-(void)layerWithShadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius;

@end
