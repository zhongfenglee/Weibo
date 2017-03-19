//
//  BaseCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class TTTAttributedLabel;

@class AvatarView;

@class TextView;

@interface BaseCell : UITableViewCell

@property (nonatomic,strong) AvatarView *avatar;// 头像
@property (nonatomic,strong) UILabel *screenName;// 昵称
@property (nonatomic,strong) UIImageView *mbImageView;// 会员

@property (nonatomic,strong) UILabel *time;// 时间
//@property (nonatomic,strong) UILabel *text;// 内容
//@property (nonatomic,strong) TTTAttributedLabel *text;// 内容
//@property (nonatomic,strong) UITextView *text;// 内容

@property (nonatomic,strong) TextView *textView;

@property (nonatomic,strong) UILabel *source;// 来源

@end
