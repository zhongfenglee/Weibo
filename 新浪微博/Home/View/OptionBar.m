//
//  OptionBar.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/22.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "OptionBar.h"
#import "UIButton+Helper.h"
#import "UIImage+Helper.h"
#import "ZFConst.h"
#import "Status.h"

@interface OptionBar ()

@property (nonatomic,strong) UIButton *retweetBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *likeBtn;

@end

@implementation OptionBar

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
        // 让按钮能接受点击事件(UIImageView默认不接受点击事件)
        self.userInteractionEnabled = YES;
        // 设置整个optionBar的背景
        self.image = [UIImage stretchImageWithImageName:@"timeline_card_bottom_background"];
        
        // 自动伸缩属性：随父控件的高度的变化而自动伸缩与父控件顶部的距离，粘着父控件底部
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

        // 1.添加3个按钮
        _retweetBtn = [UIButton buttonWithImage:@"timeline_icon_retweet" selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:@"timeline_card_middle_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"转发" target:self action:@selector(retweet)];
        
        _commentBtn = [UIButton buttonWithImage:@"timeline_icon_comment" selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:@"timeline_card_middle_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"评论" target:self action:@selector(comment)];
        
        _likeBtn = [UIButton buttonWithImage:@"timeline_icon_like" selectedImageNameAppend:@"_able" highlightedImageNameAppend:nil backgroundImageName:@"timeline_card_middle_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"赞" target:self action:@selector(like)];

        [self addSubview:_retweetBtn];
        [self addSubview:_commentBtn];
        [self addSubview:_likeBtn];
        
//        for (UIButton *btn in self.subviews) {
//            [btn setTitleColor:LeeColor(112,112,112,1.0) forState:UIControlStateNormal];
//            btn.titleLabel.font = kFont(14);
//            
//            // button的imageView的右边有5的间距
//            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//            // button的titleLabel的左边有5的间距
//            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//        }
        // 也可以这么说
        CGFloat btnWidth = self.frame.size.width / 3;
//        CGFloat btnHeight = self.frame.size.height;

        NSUInteger count = self.subviews.count;
        
        for (int i = 0; i < count; i++) {
            UIButton *btn = self.subviews[i];
            
            [btn setTitleColor:LeeColor(61,61,61,1.0) forState:UIControlStateNormal];
            btn.titleLabel.font = kFont(14);
            
            btn.frame = CGRectMake(i * btnWidth, 1, btnWidth, kOptionBarHeight - 1);
            
            // button的imageView的右边有5的间距
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
            // button的titleLabel的左边有5的间距
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            
            if (i) {
                UIImageView *separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
                separator.center = CGPointMake(btn.frame.origin.x, kOptionBarHeight * 0.5);
                [self addSubview:separator];
            }
        }
        
        UIImageView *topSeparator = [[UIImageView alloc] init];
        topSeparator.image = [UIImage stretchImageWithImageName:@"timeline_bubble_content_separator"];
        topSeparator.frame = CGRectMake(0, 0, 0, 2);
        topSeparator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:topSeparator];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
//    CGFloat btnWidth = frame.size.width / 3;
//    CGFloat btnHeight = frame.size.height;
//    
//    NSUInteger count = self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        UIButton *btn = self.subviews[i];
//        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
//        
//        UIImageView *topSeparator = [[UIImageView alloc] init];
//        topSeparator.image = [UIImage stretchImageWithImageName:@"timeline_bubble_content_separator"];
//        topSeparator.frame = CGRectMake(0, 0, btnWidth, 0.5);
////        topSeparator.autoresizingMask = UIViewAutoresizingFlexibleWidth;// 自动伸缩属性
//        [btn addSubview:topSeparator];
//    
//        if (i) {
//            UIImageView *separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
//            separator.center = CGPointMake(btn.frame.origin.x, btnHeight * 0.5);
//            [self addSubview:separator];
//        }
//    }
//    
////    // 也可以这么写
////    for (UIButton *btn in self.subviews) {
////        NSUInteger i = [self.subviews indexOfObject:btn];
////        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
////    }
    
    frame.size.width = kScreenWidth - 2 * kTableViewBorder;
    frame.size.height = kOptionBarHeight;
    
    [super setFrame:frame];
}

-(void)setStatus:(Status *)status
{
    _status = status;
    
    NSString *retweetBtnTitle = [self btnTitleWithCount:status.repostsCount title:@"转发"];
    NSString *commentBtnTitle = [self btnTitleWithCount:status.commentsCount title:@"评论"];
    NSString *likeBtnTitle = [self btnTitleWithCount:status.attitudesCount title:@"赞"];

    [_retweetBtn setTitle:retweetBtnTitle forState:UIControlStateNormal];
    [_commentBtn setTitle:commentBtnTitle forState:UIControlStateNormal];
    [_likeBtn setTitle:likeBtnTitle forState:UIControlStateNormal];
}

#pragma mark - 转发、评论、赞 字符串处理
-(NSString *)btnTitleWithCount:(int)count title:(NSString *)title
{
    NSString *btnTitle = @"";
    
    if (count >= 10000) {// 上万：展示x万、x.x万、xx万、xxx万等
        CGFloat count1 = count / 10000.0;
        btnTitle = [NSString stringWithFormat:@"%.1f万",count1];
        // 替换.0为空串
        btnTitle = [btnTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{// 一万以内：1-9999:展示x、xx、xxx；0:展示对应的title
        btnTitle = count? [NSString stringWithFormat:@"%d",count] : title;
    }

    return btnTitle;
}

-(void)retweet
{
    NSLog(@"retweet");
}

-(void)comment
{
    NSLog(@"comment");
}

-(void)like
{
    NSLog(@"like");
}

@end
