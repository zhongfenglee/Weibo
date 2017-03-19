//
//  BaseStatusCommentRepostLikeCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatusCommentRepostLikeCell.h"
#import "AvatarView.h"
#import "BaseStatusCommentRepostLikeCellFrame.h"
#import "Status.h"
#import "User.h"

#import "TextView.h"

//#import "TTTAttributedLabel.h"

@interface BaseStatusCommentRepostLikeCell ()

//@property (nonatomic,strong) AvatarView *avatarView;// 头像
//@property (nonatomic,strong) UILabel *screenName;// 昵称
//@property (nonatomic,strong) UIImageView *mbImageView;// 会员

//@property (nonatomic,strong) UILabel *time;// 时间
//@property (nonatomic,strong) UILabel *text;// 内容

@end

@implementation BaseStatusCommentRepostLikeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控件到contentView中
        [self addSubViewsToContentView];
    }
    
    return self;
}

-(void)addSubViewsToContentView
{
    [self.contentView addSubview:self.avatar];// 头像
    [self.contentView addSubview:self.screenName];// 昵称
    [self.contentView addSubview:self.mbImageView];// 会员
    [self.contentView addSubview:self.time];// 时间
//    [self.contentView addSubview:self.source];
//    [self.contentView addSubview:self.text];// 内容
    [self.contentView addSubview:self.textView];
}

-(void)setBaseStatusCommentRepostLikeCellFrame:(BaseStatusCommentRepostLikeCellFrame *)baseStatusCommentRepostLikeCellFrame
{
    _baseStatusCommentRepostLikeCellFrame = baseStatusCommentRepostLikeCellFrame;
    BaseStatus *baseStatus = baseStatusCommentRepostLikeCellFrame.baseStatus;
    User *user = baseStatus.user;
    
    // 头像
    [self.avatar setUser:user avatarType:kAvatarTypeSmall];
    self.avatar.frame = baseStatusCommentRepostLikeCellFrame.avatarFrame;
    
    // 昵称
    self.screenName.text = user.screenName;
    self.screenName.frame = baseStatusCommentRepostLikeCellFrame.screenNameFrame;
    
    // 会员图标
    self.mbImageView.frame = baseStatusCommentRepostLikeCellFrame.mbRankFrame;
    if (user.mbType == kMBTypeNone) {// 若不是会员，将__mbImageView隐藏
        self.screenName.textColor = LeeColor(93,93,93,1.0);
        self.mbImageView.hidden = YES;
    }else{// 是会员，变换昵称颜色，显示_mbImageView
        self.screenName.textColor = LeeColor(243,101,18,1.0);
        self.mbImageView.hidden = NO;
        self.mbImageView.frame = baseStatusCommentRepostLikeCellFrame.mbRankFrame;
        self.mbImageView.image = [UIImage imageNamed:[@"common_icon_membership_level" stringByAppendingFormat:@"%d",user.mbRank]];
    }
    
    // 时间
    self.time.text = baseStatus.createdAt;
    self.time.frame = baseStatusCommentRepostLikeCellFrame.timeFrame;
    [self.time sizeToFit];

    // 内容
//    self.text.text = baseStatus.text;
//    self.text.attributedText = baseStatus.attStrM;
//    self.text.frame = baseStatusCommentRepostLikeCellFrame.textFrame;
    self.textView.attributedText = baseStatus.attStrM;
    self.textView.frame = baseStatusCommentRepostLikeCellFrame.textFrame;
//    self.textView.frame = (CGRect){baseStatusCommentRepostLikeCellFrame.textFrame.origin, self.textView.contentSize};
//    [self.textView sizeToFit];
//    [self.textView layoutIfNeeded];
}

@end
