//
//  HZWaitingView.m
//  HZPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HZWaitingView.h"
@implementation HZWaitingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mode = HZWaitingViewProgressMode;
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        self.clipsToBounds = YES;
        self.backgroundColor = LeeColor(0,0,0,0.5);
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];// 需要重新绘制时，应使用setNeedsDisplay来重新调用- (void)drawRect:(CGRect)rect
    if (progress >= 1) {
        [self removeFromSuperview];
    }
}

- (void)setFrame:(CGRect)frame
{
    //设置背景图为圆
    frame.size.width = frame.size.height = 50;
    [super setFrame:frame];
}

#pragma mark - 重写-drawRect:方法
// 重写-drawRect:方法可以自定义想要画的图案
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();// 获取一个与视图相关联的上下文
    
    // 圆心
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    // 半径
//    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - HZWaitingViewItemMargin;
    
    // 填充白色
    [LeeColor(255,255,255,1.0) set];// 这里的set会根据下面的CGContextFillPath或CGContextStrokePath自动选择调用setFill还是setStroke
    
    switch (self.mode) {
        case HZWaitingViewModePieDiagram:{// 饼形
            // 先画外面的大圆弧
//            CGFloat w = radius * 2 + HZWaitingViewItemMargin;
//            CGFloat h = w;
//            CGFloat x = (rect.size.width - w) * 0.5;
//            CGFloat y = (rect.size.height - h) * 0.5;
            CGFloat x = rect.origin.x + HZWaitingViewItemMargin;
            CGFloat y = rect.origin.y + HZWaitingViewItemMargin;
            CGFloat w = rect.size.width - 2 * HZWaitingViewItemMargin;
            CGFloat h = rect.size.height - 2 * HZWaitingViewItemMargin;
            CGContextSetLineWidth(ctx, 2);// 线宽
            CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));// 画圆（必须配合CGContextFillPath或CGContextStrokePath使用）
//            CGContextFillPath(ctx);// 填充模式画出圆面
            CGContextStrokePath(ctx);// 直线模式画出圆弧
            
//            [LeeColor(0,0,0,0.7) set];
            CGContextMoveToPoint(ctx, xCenter, yCenter);// 定义起始点
//            CGContextAddLineToPoint(ctx, xCenter, 0);
            CGFloat radius = MIN(w, h) * 0.5 - HZWaitingViewItemMargin;// 半径
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 终止角度
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);// 0：顺时针   1：逆时针
            CGContextClosePath(ctx);// 闭合路径（该函数会将所画出的图形中的断点分别与起始点连接起来，形成闭合的路径）
            CGContextFillPath(ctx);// 将闭合路径填充起来
        }
            break;
        default:{// 环形
            CGContextSetLineWidth(ctx, 4);// 线宽
            CGContextSetLineCap(ctx, kCGLineCapRound);// 线终点类型
            CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;// 半径
            CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 终止角度
            CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);// 画圆（默认画圆面，加上CGContextStrokePath后就画成圆弧）
            CGContextStrokePath(ctx);// 直线模式画圆弧
        }
            break;
    }
}

@end
