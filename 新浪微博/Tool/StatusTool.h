//
//  StatusTool.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//  负责管理微博数据：抓取微博数据、发送微博

#import <Foundation/Foundation.h>

@class Status;

// status装的都是Status对象
typedef void(^StatusSuccess)(NSArray *array);
typedef void(^StatusFailure)(NSError *error);

typedef void(^CommentSuccess)(NSArray *array, int commentTotalNumber, int64_t nextCursor);
typedef void(^CommentFailure)(NSError *error);

typedef void(^RepostSuccess)(NSArray *array, int repostTotalNumber, int64_t nextCursor);
typedef void(^RepostFailure)(NSError *error);

typedef void(^SingleStatusSuccess)(Status *status);
typedef void(^SingleStatusFailure)(NSError *error);


@interface StatusTool : NSObject

// 返回微博数据
+(void)statusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId statusSuccess:(StatusSuccess)statusSuccess statusFailure:(StatusFailure)statusFailure;

// 返回评论数据
+(void)statusCommentsWithStatusId:(int64_t)statusId sinceId:(int64_t)sinceId maxId:(int64_t)maxId commentSuccess:(CommentSuccess)commentSuccess commentFailure:(CommentFailure)commentFailure;

// 返回转发数据
+(void)statusRepostsWithStatusId:(int64_t)statusId sinceId:(int64_t)sinceId maxId:(int64_t)maxId repostSuccess:(RepostSuccess)repostSuccess repostFailure:(RepostFailure)repostFailure;

// 返回单条微博数据
+(void)singleStatusWithStatusId:(int64_t)statusId singleStatusSuccess:(SingleStatusSuccess)singleStatusSuccess singleStatusFailure:(SingleStatusFailure)singleStatusFailure;

@end
