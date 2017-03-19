//
//  BaseStatusCommentRepostLikeCellFrame.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseStatus;

@interface BaseStatusCommentRepostLikeCellFrame : NSObject

@property (nonatomic,strong) BaseStatus *baseStatus;

@property (nonatomic,readonly,assign) CGRect avatarFrame;// 头像尺寸
@property (nonatomic,readonly,assign) CGRect screenNameFrame;// 昵称尺寸
@property (nonatomic,readonly,assign) CGRect mbRankFrame;// 会员尺寸
@property (nonatomic,readonly,assign) CGRect timeFrame;// 时间尺寸
@property (nonatomic,readonly,assign) CGRect textFrame;// 正文尺寸

@property (nonatomic,assign) CGFloat cellHeight;// cell的高度


@end
