//
//  StatusTool.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"

#import "HomeCellFrame.h"
#import "Comment.h"
#import "Repost.h"

@implementation StatusTool

// since_id：返回最新的微博；max_id：返回较旧的微博
+(void)statusesWithSinceId:(int64_t)sinceId maxId:(int64_t)maxId statusSuccess:(StatusSuccess)statusSuccess statusFailure:(StatusFailure)statusFailure
{
    [HttpTool AFN_GetWithURLString:kStatuses_Home_Timeline params:@{@"access_token":kAccessToken,@"count":@10,@"since_id ":@(sinceId),@"max_id":@(maxId)} success:^(id JSON) {
        if (statusSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        NSMutableArray *statusM = [NSMutableArray array];
        NSArray *statusA = JSON[@"statuses"];
        NSLog(@"statusA: %@",statusA);
        // 数组里面是一个一个的字典，这些字典分别对应的不同种类的内容
        for (NSDictionary *oneStatusDict in statusA) {
            Status *status = [[Status alloc] initWithDict:oneStatusDict];
            [statusM addObject:status];
        }
        statusSuccess(statusM);
    } failure:^(NSError *error) {
        if (statusFailure == nil) return;
        statusFailure(error);
    }];
}

// 返回微博评论数据
+(void)statusCommentsWithStatusId:(int64_t)statusId sinceId:(int64_t)sinceId maxId:(int64_t)maxId commentSuccess:(CommentSuccess)commentSuccess commentFailure:(CommentFailure)commentFailure
{
    [HttpTool AFN_GetWithURLString:kStatuses_Comments_Show params:@{@"access_token":kAccessToken,@"id":@(statusId),@"since_id ":@(sinceId),@"max_id":@(maxId),@"count":@5} success:^(id JSON) {
        if (commentSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        NSArray *commentsA = JSON[@"comments"];
        NSMutableArray *commentsM = [NSMutableArray array];
        // 数组里面是一个一个的字典，这些字典分别对应的不同种类的内容
        for (NSDictionary *oneCommentDict in commentsA) {
            Comment *comment = [[Comment alloc] initWithDict:oneCommentDict];
            [commentsM addObject:comment];
        }
        commentSuccess(commentsM, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (commentFailure == nil) return;
        commentFailure(error);
    }];
}

// 返回指定微博的转发微博列表
+(void)statusRepostsWithStatusId:(int64_t)statusId sinceId:(int64_t)sinceId maxId:(int64_t)maxId repostSuccess:(RepostSuccess)repostSuccess repostFailure:(RepostFailure)repostFailure
{
    [HttpTool AFN_GetWithURLString:kStatuses_Reposts_Show params:@{@"access_token":kAccessToken,@"id":@(statusId),@"since_id ":@(sinceId),@"max_id":@(maxId),@"count":@5} success:^(id JSON) {
        if (repostSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        NSArray *repostA = JSON[@"reposts"];
        NSLog(@"repostA:%@",repostA);
        NSMutableArray *repostM = [NSMutableArray array];
        // 数组里面是一个一个的字典，这些字典分别对应的不同种类的内容
        for (NSDictionary *oneRepostDict in repostA) {
            Repost *repost = [[Repost alloc] initWithDict:oneRepostDict];
            [repostM addObject:repost];
        }
        repostSuccess(repostM, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (repostFailure == nil) return;
        repostFailure(error);
    }];
}

+(void)singleStatusWithStatusId:(int64_t)statusId singleStatusSuccess:(SingleStatusSuccess)singleStatusSuccess singleStatusFailure:(SingleStatusFailure)singleStatusFailure
{
    [HttpTool AFN_GetWithURLString:kSingle_Statuses_Show params:@{@"access_token":kAccessToken,@"id":@(statusId)} success:^(id JSON) {
        if (singleStatusSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        Status *status = [[Status alloc] initWithDict:JSON];
        singleStatusSuccess(status);
    } failure:^(NSError *error) {
        if (singleStatusFailure == nil) return;
        singleStatusFailure(error);
    }];
}

@end
