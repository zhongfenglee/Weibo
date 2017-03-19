//
//  RetweetedStatusOptionBar.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/29.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "RetweetedStatusOptionBar.h"
#import "UIButton+Helper.h"
#import "Status.h"
#import "ZFConst.h"
#import "UIImage+Helper.h"

@interface RetweetedStatusOptionBar ()

@property (nonatomic,strong) UIButton *retweetBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *likeBtn;

@end

@implementation RetweetedStatusOptionBar

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
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]];

        // 始终粘着父控件的游侠角（动态调整和父控件的顶部的距离，和父控件的右边的距离）
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        // 1.添加3个按钮
        _retweetBtn = [UIButton buttonWithImage:@"timeline_icon_retweet" selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:@"timeline_retweet_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"0" target:self action:@selector(retweet)];
        
        _commentBtn = [UIButton buttonWithImage:@"timeline_icon_comment" selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:@"timeline_retweet_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"0" target:self action:@selector(comment)];
        
        _likeBtn = [UIButton buttonWithImage:@"timeline_icon_like" selectedImageNameAppend:@"_able" highlightedImageNameAppend:nil backgroundImageName:@"timeline_retweet_background" highlightedBgImageNameAppend:@"_highlighted" selectedBgImageNameAppend:nil title:@"0" target:self action:@selector(like)];
        
        [self addSubview:_retweetBtn];
        [self addSubview:_commentBtn];
        [self addSubview:_likeBtn];
        
        // 也可以这么说
        CGFloat btnWidth = self.frame.size.width / 3;
        CGFloat btnHeight = self.frame.size.height;
        
        NSUInteger count = self.subviews.count;
        
        for (int i = 0; i < count; i++) {
            UIButton *btn = self.subviews[i];
            [btn setTitleColor:LeeColor(61,61,61,1.0) forState:UIControlStateNormal];
            btn.titleLabel.font = kFont(13);
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
            btn.backgroundColor = [UIColor clearColor];
            
            // button的imageView的右边有5的间距
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
            // button的titleLabel的左边有5的间距
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }
    }
    
    return self;
}

#pragma mark - 内部将自身宽高定死
-(void)setFrame:(CGRect)frame
{
    frame.size.width = 250;
    frame.size.height = kRetweetedStatusOptionBarHeight;
    
    [super setFrame:frame];
}

-(void)setStatus:(Status *)status
{
    _status = status;
    
    NSString *retweetBtnTitle = [self btnTitleWithCount:status.repostsCount title:@"0"];
    NSString *commentBtnTitle = [self btnTitleWithCount:status.commentsCount title:@"0"];
    NSString *likeBtnTitle = [self btnTitleWithCount:status.attitudesCount title:@"0"];
    
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
