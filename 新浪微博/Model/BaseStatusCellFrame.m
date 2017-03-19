//
//  BaseStatusCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "ZFConst.h"
#import "User.h"
#import "AvatarView.h"
#import "ImageListView.h"
#import "NSMutableParagraphStyle+Helper.h"

@implementation BaseStatusCellFrame

#pragma mark - 重写status的setter方法，HomeVC中调用homeCellFrame.status = status;就会掉用这个方法，将status传进来，设置cell上各控件的位置和尺寸
-(void)setStatus:(Status *)status
{
    _status = status;
    
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
    NSString *screenName = status.user.screenName;
    if ([screenName containsString:@"@"]) {
        status.user.screenName = [screenName stringByReplacingOccurrencesOfString:@"@" withString:@""];
    }
    CGSize screenNameSize = [status.user.screenName sizeWithAttributes:@{NSFontAttributeName:kScreenNameFont}];
    _screenNameFrame = (CGRect){{screenNameFrameX, screenNameFrameY}, screenNameSize};
    
    // 3.会员
    if (status.user.mbType != kMBTypeNone) {
        CGFloat mbRankFrameX = CGRectGetMaxX(_screenNameFrame) + kCellBorderMargin * 0.5;
        CGFloat mbRankFrameY = screenNameFrameY + (screenNameSize.height - kMBImageViewHeight) * 0.5;
        CGSize mbRankSize = CGSizeMake(kMBImageViewWidth, kMBImageViewHeight);
        _mbRankFrame = (CGRect){{mbRankFrameX, mbRankFrameY}, mbRankSize};
    }
    
    // 4.时间
    CGFloat timeFrameX = screenNameFrameX;
    CGFloat timeFrameY = CGRectGetMaxY(_screenNameFrame) + kCellBorderMargin * 0.2;
    CGSize timeSize = [status.createdAt sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
    _timeFrame = (CGRect){{timeFrameX, timeFrameY}, timeSize};
    
    // 5.来源
    CGFloat sourceFrameX = CGRectGetMaxX(_timeFrame) + kCellBorderMargin;
    CGFloat sourceFrameY = timeFrameY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName:kSourceFont}];
    _sourceFrame = (CGRect){{sourceFrameX, sourceFrameY}, sourceSize};
    
    // 6.topViewFrame
    CGFloat topViewFrameX = 0;
    CGFloat topViewFrameY = 0;
    CGFloat topViewFrameWidth = cellWith;
    CGFloat topViewFrameHeight = CGRectGetMaxY(_avatarFrame);
    _topViewFrame = CGRectMake(topViewFrameX, topViewFrameY, topViewFrameWidth, topViewFrameHeight);
    
    // 5.内容
    CGFloat textFrameX = avatarFrameX;
    //    CGFloat maxY =  MAX(CGRectGetMaxY(_avatarFrame), CGRectGetMaxY(_sourceFrame));
    //    CGFloat textFrameY = maxY + kCellBorderMargin * 0.2;
    CGFloat textFrameY = CGRectGetMaxY(_topViewFrame) + kCellBorderMargin;
    CGFloat textFrameWidth = cellWith - 2 * kCellBorderMargin;
//    CGFloat textFrameWidth = cellWith;
    // 内容的size（宽度、高度）
    CGSize contextSize = CGSizeMake(textFrameWidth, MAXFLOAT);
    //计算文字大小,必须与显示文本的label的字体大小保持一致,属性一致
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];// 设置文字属性
//    paragraphStyle.alignment = NSTextAlignmentJustified;// 两端对齐
//    paragraphStyle.lineSpacing = kLineSpacing;// 行距
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle mutableParagraphStyleWithLineSpacing:kLineSpacing alignment:NSTextAlignmentJustified];
//
//    CGRect textRect = [status.text boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTextFont,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    CGRect textRect = [status.attStrM boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    _textFrame = (CGRect){{textFrameX, textFrameY}, textRect.size};
    
    // 6.配图(若原创微博有自己的配图，则就不会再有转发微博；若原创微博下面跟着转发微博，则不会再有原创配图)
    NSUInteger imageUrlCount = status.thumbnailPicUrls.count;// 配图
    Status *retweetedStatus = status.retweetedStatus;// 转发微博
    
    if (imageUrlCount) {// 有配图
        CGFloat figureViewFrameX = textFrameX;
        CGFloat figureViewFrameY = CGRectGetMaxY(_textFrame) + kCellBorderMargin;
        CGSize figureViewSize = [ImageListView imageListVeiwSizeWithCount:imageUrlCount];
        _FigureViewFrame = (CGRect){{figureViewFrameX, figureViewFrameY}, figureViewSize};
    }else if (retweetedStatus){// 有转发的微博
        // 转发微博的子控件
        // 7.转发微博整体(retweetedView)
        CGFloat retweetedViewFrameX = 0;
        CGFloat retweetedViewFrameY = CGRectGetMaxY(_textFrame) + kCellBorderMargin * 0.1;
        CGFloat retweetedViewFrameWidth = cellWith;
        CGFloat retweetedViewFrameHeight = kCellBorderMargin;
        
        // 8.昵称
        CGFloat retweetedScreenNameFrameX = avatarFrameX;
        CGFloat retweetedScreenNameFrameY = retweetedScreenNameFrameX - 5;
        NSString *retweetedStatusUserScreenName = retweetedStatus.user.screenName;
        if (![retweetedStatusUserScreenName containsString:@"@"]) {
            retweetedStatusUserScreenName = [@"@" stringByAppendingString:retweetedStatusUserScreenName];
            retweetedStatus.user.screenName = retweetedStatusUserScreenName;
        }
        CGSize retweetedScreenNameSize = [retweetedStatusUserScreenName sizeWithAttributes:@{NSFontAttributeName:kRetweetedScreenNameFont}];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameFrameX, retweetedScreenNameFrameY}, retweetedScreenNameSize};
        
        // 9.内容
        CGFloat retweetedTextFrameX = retweetedScreenNameFrameX;
        CGFloat retweetedTextFrameY = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderMargin;
        CGFloat retweetedTextFrameWidth = retweetedViewFrameWidth - 2 * kCellBorderMargin;
//        CGFloat retweetedTextFrameWidth = retweetedViewFrameWidth;
        CGSize contextSize = CGSizeMake(retweetedTextFrameWidth, MAXFLOAT);
        //计算时设置的字体大小,必须与显示文本的label的字体大小保持一致
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];// 设置文字属性
//        paragraphStyle.alignment = NSTextAlignmentJustified;// 两端对齐
//        paragraphStyle.lineSpacing = kLineSpacing;// 行距
//        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle mutableParagraphStyleWithLineSpacing:kLineSpacing alignment:NSTextAlignmentJustified];
//        CGRect retweetedTextRect = [retweetedStatus.text boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kRetweetedTextFont,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
        CGRect retweetedTextRect = [retweetedStatus.attStrM boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        _retweetedTextFrame = (CGRect){{retweetedTextFrameX, retweetedTextFrameY}, retweetedTextRect.size};
        
        // 10.配图
        NSUInteger retweetedImageUrlCount = retweetedStatus.thumbnailPicUrls.count;
        if (retweetedImageUrlCount) {// 转发微博中有配图
            CGFloat retweetedFigureViewFrameX = retweetedTextFrameX;
            CGFloat retweetedFigureViewFrameY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderMargin;
            CGSize retweetedFigureViewSize = [ImageListView imageListVeiwSizeWithCount:retweetedImageUrlCount];
            _retweetedFigureViewFrame = (CGRect){{retweetedFigureViewFrameX, retweetedFigureViewFrameY}, retweetedFigureViewSize};
            
            // 转发微博整体高度
            retweetedViewFrameHeight += CGRectGetMaxY(_retweetedFigureViewFrame);
        }else{// 转发微博中没有配图
            retweetedViewFrameHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        // 11.转发微博整体尺寸
        _retweetedViewFrame = CGRectMake(retweetedViewFrameX,retweetedViewFrameY,retweetedViewFrameWidth,retweetedViewFrameHeight);
    }
    
    _cellHeight = kCellMargin;
    // 12.整个cell的高度
    if (imageUrlCount) {// 原创微博中有配图
        _cellHeight += CGRectGetMaxY(_FigureViewFrame) + kCellBorderMargin;
    }else if (retweetedStatus){// 有转发的微博
        _cellHeight += CGRectGetMaxY(_retweetedViewFrame);
    }else{// 原创微博中只有文字（无配图、无转发）
        _cellHeight += CGRectGetMaxY(_textFrame) + kCellBorderMargin;
    }
}

@end
