//
//  TabBarButton.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "TabBarButton.h"
#import "NSString+Helper.h"
#import "ZFConst.h"
#import "UIButton+Helper.h"

@implementation TabBarButton

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
        // 1. 设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;// 文字居中
        self.titleLabel.font = kFont(12);// 文字大小
        
        [self setTitleColor:LeeColor(127, 127, 127, 1.0) forState:UIControlStateNormal];// 正常文字颜色
        [self setTitleColor:LeeColor(255, 127, 0, 1.0) forState:UIControlStateHighlighted];// 高亮时文字颜色
        [self setTitleColor:LeeColor(255, 127, 0, 1.0) forState:UIControlStateSelected];// 被选中时文字颜色
        
        // 2.设置图片内容模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;// 图片自适应
//        self.adjustsImageWhenHighlighted = NO;// 按下去不需要高亮状态,即图片不要变灰
        
        // 3.设置选中时的背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    }
    
    return self;
}

#pragma mark - 创建tabButton
+(instancetype)tabButtonWithNormalIcon:(NSString *)normalIcon title:(NSString *)title target:(id)target action:(SEL)action
{
//    TabBarButton *tabBarButton = [self buttonWithType:UIButtonTypeCustom];
//    
//    [tabBarButton setTitle:title forState:UIControlStateNormal];
//    [tabBarButton setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];
//    [tabBarButton setImage:[UIImage imageNamed:[normalIcon fileNameAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
//    [tabBarButton setImage:[UIImage imageNamed:[normalIcon fileNameAppend:@"_selected"]] forState:UIControlStateSelected];
//    [tabBarButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];// 手指一按下去，就切换控制器
    
    TabBarButton *tabBarButton = (TabBarButton *)[self buttonWithImage:normalIcon selectedImageNameAppend:@"_selected" highlightedImageNameAppend:@"_highlighted" backgroundImageName:nil highlightedBgImageNameAppend:nil selectedBgImageNameAppend:nil title:title target:target action:action];
        
    return tabBarButton;
}

#pragma mark - 调整tabButton的imageRect
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 1, contentRect.size.width, contentRect.size.height * kTabBarButtonImageRatio);
}

#pragma mark - 调整tabButton的titleRect
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kTabBarButtonImageRatio;
    CGFloat titleHeight = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

#pragma mark - 覆盖父类在highlighted时所有的操作
-(void)setHighlighted:(BOOL)highlighted{}

@end
