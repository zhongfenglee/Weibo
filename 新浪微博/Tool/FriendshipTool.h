//
//  FriendshipTool.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>

// 粉丝
typedef void(^FollowersSuccess)(NSArray *followers);
typedef void(^FollowersFailure)(NSError *error);

// 关注
typedef void(^FriendsSuccess)(NSArray *followers);
typedef void(^FriendsFailure)(NSError *error);

@interface FriendshipTool : NSObject

+(void)loadFollowersWithUserId:(int64_t)userId followersSuccess:(FollowersSuccess)followersSuccess followersFailure:(FollowersFailure)followersFailure;

+(void)loadFriendsWithUserId:(int64_t)userId friendsSuccess:(FriendsSuccess)friendsSuccess friendsFailure:(FriendsFailure)friendsFailure;

@end
