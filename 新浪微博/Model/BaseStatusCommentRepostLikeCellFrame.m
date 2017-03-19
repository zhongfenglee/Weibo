//
//  BaseStatusCommentRepostLikeCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatusCommentRepostLikeCellFrame.h"
#import "ZFConst.h"
#import "AvatarView.h"
#import "BaseStatus.h"
#import "User.h"
#import "NSMutableParagraphStyle+Helper.h"

@implementation BaseStatusCommentRepostLikeCellFrame

-(void)setBaseStatus:(BaseStatus *)baseStatus
{
    _baseStatus = baseStatus;
    
    CGFloat cellWith = kScreenWidth - 2 * kTableViewBorder;
    
    // 利用微博数据，计算出所有子控件的frame
    // 原创微博的子控件
    // 1.头像
    CGFloat avatarFrameX = kCellBorderMargin;
    CGFloat avatarFrameY = avatarFrameX;
    CGSize avatarSize = [AvatarView avatarViewWithType:kAvatarTypeSmall];
    _avatarFrame = (CGRect){{avatarFrameX, avatarFrameY}, avatarSize};
    
    // 2.昵称
    CGFloat screenNameFrameX = CGRectGetMaxX(_avatarFrame) + kCellBorderMargin * 0.5;
    CGFloat screenNameFrameY = avatarFrameY + kCellBorderMargin * 0.2;
    CGSize screenNameSize = [baseStatus.user.screenName sizeWithAttributes:@{NSFontAttributeName:kScreenNameFont}];
    _screenNameFrame = (CGRect){{screenNameFrameX, screenNameFrameY}, screenNameSize};
    
    // 4.时间
    CGFloat timeFrameX = screenNameFrameX;
    CGFloat timeFrameY = CGRectGetMaxY(_screenNameFrame) + kCellBorderMargin * 0.1;
    CGSize timeSize = [baseStatus.createdAt sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
    _timeFrame = (CGRect){{timeFrameX, timeFrameY}, timeSize};

    // 3.会员
    if (baseStatus.user.mbType != kMBTypeNone) {
        CGFloat mbRankFrameX = CGRectGetMaxX(_screenNameFrame) + kCellBorderMargin * 0.5;
        CGFloat mbRankFrameY = screenNameFrameY + (screenNameSize.height - kMBImageViewHeight) * 0.5;
        CGSize mbRankSize = CGSizeMake(kMBImageViewWidth, kMBImageViewHeight);
        _mbRankFrame = (CGRect){{mbRankFrameX, mbRankFrameY}, mbRankSize};
    }
    
    // 5.内容
    CGFloat textFrameX = screenNameFrameX;
    //    CGFloat maxY =  MAX(CGRectGetMaxY(_avatarFrame), CGRectGetMaxY(_sourceFrame));
    //    CGFloat textFrameY = maxY + kCellBorderMargin * 0.2;
    CGFloat textFrameY = CGRectGetMaxY(_timeFrame) + kCellBorderMargin;
    CGFloat textFrameWidth = cellWith - kCellBorderMargin - textFrameX;
//    CGFloat textFrameWidth = cellWith - kCellBorderMargin - textFrameX;
    // 内容的size（宽度、高度）
    CGSize contextSize = CGSizeMake(textFrameWidth, MAXFLOAT);
    //计算文字大小,必须与显示文本的label的字体大小保持一致
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentJustified;
//    paragraphStyle.lineSpacing = kLineSpacing;
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle mutableParagraphStyleWithLineSpacing:kLineSpacing alignment:NSTextAlignmentJustified];

//    CGRect textRect = [baseStatus.text boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTextFont,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    CGRect textRect = [baseStatus.attStrM boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    _textFrame = (CGRect){{textFrameX, textFrameY}, textRect.size};
    
    // 6.cell高度
    _cellHeight = CGRectGetMaxY(_textFrame) + kCellBorderMargin;
}

@end
