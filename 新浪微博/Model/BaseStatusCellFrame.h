//
//  BaseStatusCellFrame.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Status;

@interface BaseStatusCellFrame : NSObject

@property (nonatomic,strong) Status *status;

@property (nonatomic,readonly,assign) CGRect topViewFrame;// 顶部微博信息的尺寸
@property (nonatomic,readonly,assign) CGRect avatarFrame;// 头像尺寸
@property (nonatomic,readonly,assign) CGRect screenNameFrame;// 昵称尺寸
@property (nonatomic,readonly,assign) CGRect mbRankFrame;// 会员尺寸
@property (nonatomic,readonly,assign) CGRect timeFrame;// 时间尺寸
@property (nonatomic,readonly,assign) CGRect sourceFrame;// 来源尺寸
@property (nonatomic,readonly,assign) CGRect textFrame;// 正文尺寸
@property (nonatomic,readonly,assign) CGRect FigureViewFrame;// 配图尺寸

@property (nonatomic,assign) CGRect retweetedViewFrame;// 被转发微博的总体控件尺寸(盛放下面三个子控件)
@property (nonatomic,readonly,assign) CGRect retweetedScreenNameFrame;// 被转发微博的作者的昵称尺寸
@property (nonatomic,readonly,assign) CGRect retweetedTextFrame;// 被转发微博的配图尺寸
@property (nonatomic,readonly,assign) CGRect retweetedFigureViewFrame;// 被转发微博的配图尺寸

@property (nonatomic,assign) CGFloat cellHeight;// cell的高度

@end
