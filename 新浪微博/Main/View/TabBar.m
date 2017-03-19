//
//  TabBar.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
#import "CALayer+Helper.h"

@interface TabBar ()

@property (nonatomic,strong) TabBarButton *selectedTabBarButton;

@end

@implementation TabBar

single_implementation(TabBar)

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
        // tabBar的背景颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
        [self.layer setNeedsDisplay];
    }
    
    return self;
}

#pragma mark - 创建tabBarButton并添加到tabBar上
-(void)addTabBarButtonWithNormalIcon:(NSString *)normalIcon title:(NSString *)title
{
    // 1、创建tabBarButton
    TabBarButton *tabBarButton = [TabBarButton tabButtonWithNormalIcon:normalIcon title:title target:self action:@selector(tabBarButtonDidSelect:)];
    
    // 2、添加tabBarButton到tabBar上
    [self addSubview:tabBarButton];
    
    // 3、调整tabBarButton的位置和尺寸
    [self adjustTabBarButtonFrame];
    
    // 4、tabBarButton的tag
    tabBarButton.tag = self.subviews.count - 1;
    
    // 5、默认选中第一个按钮
    if (self.subviews.count == 1) {
        [self tabBarButtonDidSelect:tabBarButton];
    }
}

#pragma mark - 调整tabBarButton的位置和尺寸
-(void)adjustTabBarButtonFrame
{
    NSUInteger tabBarButtonCount = self.subviews.count;
    
    CGFloat tabBarButtonWidth = self.frame.size.width / tabBarButtonCount;
    CGFloat tabBarButtonHeight = self.frame.size.height;
    
    for (int i = 0; i < tabBarButtonCount; i++) {// 取出tabBarButton
        TabBarButton *tabBarButton = self.subviews[i];
        
        tabBarButton.frame = CGRectMake(i * tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight);
    }
}

#pragma mark - 监听tabBarButton点击事件
-(void)tabBarButtonDidSelect:(TabBarButton *)tabBarButton
{
    if (tabBarButton == self.selectedTabBarButton) return;
    
    // 执行tabBarButtonDidSelectBlock
    if (self.tabBarButtonDidSelectBlock) {
        self.tabBarButtonDidSelectBlock(self.selectedTabBarButton.tag,tabBarButton.tag);
    }

    // 更新被选中的tabBarButton
    self.selectedTabBarButton.selected = NO;
    tabBarButton.selected = YES;
    self.selectedTabBarButton = tabBarButton;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    // 添加向上的阴影
    [self.layer layerWithShadowColor:LeeColor(0,0,0,1.0) shadowOpacity:0.2 shadowOffset:CGSizeMake(0, -0.5) shadowRadius:0.2];
}

@end
