//
//  BaseStatusCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseCell.h"

@class BaseStatusCellFrame;

@interface BaseStatusCell : BaseCell

@property (nonatomic,strong) BaseStatusCellFrame *baseStatusCellFrame;

@property (nonatomic,strong) UIView *retweetedView;// 该控件盛放着被转发微博的昵称、内容、配图，用来做该区域的背景色操作

@end
