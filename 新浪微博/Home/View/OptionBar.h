//
//  OptionBar.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/22.
//  Copyright © 2016年 李中峰. All rights reserved.
//  转发、评论、赞按钮集合体

#import <UIKit/UIKit.h>

@class Status;

@interface OptionBar : UIImageView

@property (nonatomic,strong) Status *status;

@end
