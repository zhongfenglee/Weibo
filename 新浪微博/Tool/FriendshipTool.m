//
//  FriendshipTool.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "FriendshipTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "User.h"

@implementation FriendshipTool

+(void)loadFollowersWithUserId:(int64_t)userId followersSuccess:(FollowersSuccess)followersSuccess followersFailure:(FollowersFailure)followersFailure
{
    [HttpTool AFN_GetWithURLString:kFriendships_followers params:@{@"access_token":kAccessToken,@"uid":@(userId)} success:^(id JSON) {
        if (followersSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        NSArray *array = JSON[@"users"];
        NSMutableArray *followersM = [NSMutableArray array];
        // 数组里面是一个一个的字典，这些字典分别对应的不同种类的内容
        for (NSDictionary *oneUserDict in array) {
            User *user = [[User alloc] initWithDict:oneUserDict];
            [followersM addObject:user];
        }
        followersSuccess(followersM);
    } failure:^(NSError *error) {
        if (followersFailure == nil) return;
        followersFailure(error);
    }];
}

+(void)loadFriendsWithUserId:(int64_t)userId friendsSuccess:(FriendsSuccess)friendsSuccess friendsFailure:(FriendsFailure)friendsFailure
{
    [HttpTool AFN_GetWithURLString:kFriendships_friends params:@{@"access_token":kAccessToken,@"uid":@(userId)} success:^(id JSON) {
        if (friendsSuccess == nil) return;// block如果为空的话（如将block设置为nil），强行调用block会报错
        NSArray *array = JSON[@"users"];
        NSMutableArray *followersM = [NSMutableArray array];
        // 数组里面是一个一个的字典，这些字典分别对应的不同种类的内容
        for (NSDictionary *oneUserDict in array) {
            User *user = [[User alloc] initWithDict:oneUserDict];
            [followersM addObject:user];
        }
        friendsSuccess(followersM);
    } failure:^(NSError *error) {
        if (friendsFailure == nil) return;
        friendsFailure(error);
    }];
}

@end
