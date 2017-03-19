//
//  DetailHeader.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "DetailHeader.h"
#import "UIButton+Helper.h"
#import "UIImage+Helper.h"
#import "ZFConst.h"
#import "Status.h"
#import "CALayer+Helper.h"

// 当一个类只用在另一个类内部的时候，就可以这样写，不用单独建立.h和.m文件
@interface Button : UIButton

//typedef enum{
//    DetailHeaderRetweetBtn,
//    DetailHeaderCommentBtn,
//    DetailHeaderLikeBtn
//} DetailHeaderBtnType;

//@property(nonatomic,assign) DetailHeaderBtnType detailHeaderBtnType;

@end

@implementation Button : UIButton

// 长按按钮时，图片和文字不要变灰
-(void)setHighlighted:(BOOL)highlighted{}

@end

@interface DetailHeader()

@property (nonatomic,strong) Button *repostBtn;
@property (nonatomic,strong) Button *commentBtn;
@property (nonatomic,strong) Button *likeBtn;

@property (nonatomic,strong) UIImageView *bottomIndicator;

@property (nonatomic,strong) Button *selectedBtn;

@end

@implementation DetailHeader

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
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_middle_background"]];
        self.frame = CGRectMake(0, 0, kScreenWidth, kDetailHeaderHeight);
        
        [self.layer setNeedsDisplay];
        
        // 1.添加3个按钮
        _repostBtn = (Button *)[Button buttonWithImage:nil selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:nil highlightedBgImageNameAppend:nil selectedBgImageNameAppend:nil title:@"转发" target:self action:@selector(updateBtnClicked:)];
//        _retweetBtn.detailHeaderBtnType = DetailHeaderRetweetBtn;
        
        _commentBtn = (Button *)[Button buttonWithImage:nil selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:nil highlightedBgImageNameAppend:nil selectedBgImageNameAppend:nil title:@"评论" target:self action:@selector(updateBtnClicked:)];
//        _commentBtn.detailHeaderBtnType = DetailHeaderCommentBtn;
        _commentBtn.selected = YES;
        _selectedBtn = _commentBtn;
        
        _likeBtn = (Button *)[Button buttonWithImage:nil selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:nil highlightedBgImageNameAppend:nil selectedBgImageNameAppend:nil title:@"赞" target:self action:@selector(updateBtnClicked:)];
//        _likeBtn.detailHeaderBtnType = DetailHeaderLikeBtn;
        
        [self addSubview:_repostBtn];
        [self addSubview:_commentBtn];
        [self addSubview:_likeBtn];
        
        CGFloat btnY = 0;
        CGFloat btnWidth = 80;
        CGFloat btnHeight = kDetailHeaderHeight - kBottomIndicatorHeight;
        
        CGFloat bottomIndicatorCenterY = kDetailHeaderHeight - kBottomIndicatorHeight * 0.5;
        
        NSUInteger count = self.subviews.count;
        
        // 设置按钮的位置、尺寸
        for (NSUInteger i = 0; i < count; i ++) {
            Button *btn = self.subviews[i];
                        
//            btn.adjustsImageWhenHighlighted = NO;
            
            [btn setTitleColor:LeeColor(127,127,127,1.0) forState:UIControlStateNormal];
            [btn setTitleColor:LeeColor(51,51,51,1.0) forState:UIControlStateSelected];
            btn.titleLabel.font = kFont(15);
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
//            CGRect rect = btn.frame;
//            rect.origin.y = btnY;
//            rect.size.width = btnWidth;
//            rect.size.height = btnHeight;
            
            if (i < count - 1) {
//                rect.origin.x = i * btnWidth;
                
                btn.frame = CGRectMake(i * btnWidth, btnY, btnWidth, btnHeight);

//                // 默认选中“评论”按钮
//                btn.selected = i;
//                _selectedBtn = btn;
                
            }else{
//                rect.origin.x = self.frame.size.width - btnWidth;
                btn.frame = CGRectMake(self.frame.size.width - btnWidth, btnY, btnWidth, btnHeight);
            }
            
//            btn.frame = rect;
        }
        
        // 橘红色标识
        _bottomIndicator = [[UIImageView alloc] init];
        _bottomIndicator.bounds = CGRectMake(0, 0, btnWidth, kBottomIndicatorHeight);
        _bottomIndicator.center = CGPointMake(_selectedBtn.center.x, bottomIndicatorCenterY);
        _bottomIndicator.image = [UIImage stretchImageWithImageName:@"detailHeader_bottom_indicator_background"];
        
        [self addSubview:_bottomIndicator];
    }
        
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [self.layer layerWithShadowColor:LeeColor(0,0,0,1.0) shadowOpacity:0.2 shadowOffset:CGSizeMake(0, 0.5) shadowRadius:0.2];
}

// 在控件的类内部中重写-setFrame:方法会把该控件类的对象尺寸或位置定死，外界调用xxx.frame的setter的点语法时，将会来到该方法
// 但当外界使用[[XXX alloc] init] 或者 [[XXX alloc] initWithFrame:CGRectMake()]方法时，不会调用该-setFrame:方法，而是直接掉用XXX类内部的-initWithFrame:方法。因此，也可以在-initWithFrame:方法设置该XXX类的位置或尺寸，使用self.frame = CGRectMake( );
//-(void)setFrame:(CGRect)frame
//{
//    frame.size.width = kScreenWidth;
//    frame.size.height = kDetailHeaderHeight;
//    
////    frame.size = self.bounds.size;
//    
//    [super setFrame:frame];
//}


-(void)updateBtnClicked:(Button *)btn
{
    NSUInteger index = [self.subviews indexOfObject:btn];

    if (index == 0) {
        self.detailHeaderBtnType = kDetailHeaderRepostBtn;
    }else if (index == 1){
        self.detailHeaderBtnType = kDetailHeaderCommentBtn;
    }else if(index == 2){
        self.detailHeaderBtnType = kDetailHeaderLikeBtn;
    }
    
    if (self.btnClickedBlock) {
        self.btnClickedBlock(self.detailHeaderBtnType);
    }
    
    if (_selectedBtn == btn) return;
    
    // 更新被选中的tabBarButton
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _bottomIndicator.center;
        center.x = _selectedBtn.center.x;
        _bottomIndicator.center = center;
    }];
}

-(void)setStatus:(Status *)status
{
    _status = status;
    
    NSString *retweetBtnTitle = [self btnTitleWithCount:status.repostsCount title:@"转发"];
    NSString *commentBtnTitle = [self btnTitleWithCount:status.commentsCount title:@"评论"];
    NSString *likeBtnTitle = [self btnTitleWithCount:status.attitudesCount title:@"赞"];
    
    [_repostBtn setTitle:retweetBtnTitle forState:UIControlStateNormal];
    [_commentBtn setTitle:commentBtnTitle forState:UIControlStateNormal];
    [_likeBtn setTitle:likeBtnTitle forState:UIControlStateNormal];
}

-(NSString *)btnTitleWithCount:(int)count title:(NSString *)title
{
    NSString *btnTitle = @"";
    
    if (count >= 10000) {// 上万：展示x万、x.x万、xx万、xxx万等
        CGFloat count1 = count / 10000.0;
        btnTitle = [NSString stringWithFormat:@"%@ %.1f万",title,count1];
        // 替换.0为空串
        btnTitle = [btnTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{// 一万以内：1-9999:展示x、xx、xxx；0:展示对应的title
        btnTitle = count? [NSString stringWithFormat:@"%@ %d",title,count] : title;
    }
    
    return btnTitle;
}

@end
