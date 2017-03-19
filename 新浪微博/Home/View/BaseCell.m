//
//  BaseCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseCell.h"
#import "UIImage+Helper.h"
#import "AvatarView.h"
#import "CALayer+Helper.h"

//#import "TTTAttributedLabel.h"
#import "TextView.h"

@interface BaseCell ()

@end

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBgView];
        
        [self addSubviews];
                
        // 使用CALayer绘图时，应重写-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx方法，同时让layer调用-setNeedsDisplay方法
        [self.layer setNeedsDisplay];
    }
    
    return self;
}

#pragma mark - 设置cell的默认背景图片和被选中时的背景图片
-(void)setBgView
{
    // 先清空backgroundColor，否则会出现背景图片加载的不好
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.selectedBackgroundView = nil;
    
    // 1.设置默认背景
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage stretchImageWithImageName:@"common_card_background"]];
    // 2.长按背景
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage stretchImageWithImageName:@"common_card_background_highlighted"]];
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    [self.layer layerWithShadowColor:LeeColor(0,0,0,1.0) shadowOpacity:0.2 shadowOffset:CGSizeMake(0, 0.5) shadowRadius:0.2];
}

-(void)addSubviews
{
    // 1.头像
    self.avatar = [[AvatarView alloc] init];
    
    // 2.昵称
    self.screenName = [[UILabel alloc] init];
    self.screenName.font = kScreenNameFont;
    self.screenName.backgroundColor = [UIColor clearColor];
    
    // 3.皇冠图标
    self.mbImageView = [[UIImageView alloc] init];
    
    // 4.时间
    self.time = [[UILabel alloc] init];
    self.time.font = kTimeFont;
    self.time.textColor = LeeColor(127,127,127,1.0);
    self.time.backgroundColor = [UIColor clearColor];
    
    // 8.内容
//    self.text = [[UILabel  alloc] init];
////    self.text = [[TTTAttributedLabel  alloc] initWithFrame:CGRectZero];
////    self.text = [[UITextView alloc] init];
////    self.text.editable = NO;
////    self.text.dataDetectorTypes = UIDataDetectorTypeAll;
////    self.text.selectable = YES;
////    self.text.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    self.text.numberOfLines = 0;
//    self.text.lineBreakMode = NSLineBreakByWordWrapping;
//    self.text.backgroundColor = [UIColor clearColor];
    
    self.textView = [[TextView alloc] init];
    
    // 5.来源
    self.source = [[UILabel alloc] init];
    self.source.font = kSourceFont;
    self.source.textColor = LeeColor(127,127,127,1.0);
    self.source.backgroundColor = [UIColor clearColor];
    
//    // 添加到cell中
//    [self.contentView addSubview:self.avatar];
//    [self.contentView addSubview:self.screenName];
//    [self.contentView addSubview:self.mbImageView];
//    [self.contentView addSubview:self.time];
//    [self.contentView addSubview:self.text];
}

@end
