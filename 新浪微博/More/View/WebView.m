//
//  WebView.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/7.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "WebView.h"

@implementation WebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.scalesPageToFit = YES;// 让webView可以将html页面缩放至其视口大小，从而达到整屏显示html页面内容的效果，同时可以让用户通过捏合手势来缩放页面查看内容
        self.frame = kScreenFrame;
    }
    
    return self;
}

@end
