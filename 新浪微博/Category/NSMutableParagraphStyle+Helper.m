//
//  NSMutableParagraphStyle+Helper.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/8/5.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NSMutableParagraphStyle+Helper.h"

@implementation NSMutableParagraphStyle (Helper)

+(NSMutableParagraphStyle *)mutableParagraphStyleWithLineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *mutableParagraphStyle = [[self alloc] init];
    
    mutableParagraphStyle.lineSpacing = lineSpacing;// 间距
    mutableParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    mutableParagraphStyle.alignment = alignment;// 文字两端对齐
    
    return mutableParagraphStyle;
}

@end
