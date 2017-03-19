//
//  AvatarView.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//  头像

#import <UIKit/UIKit.h>

typedef enum {
    kAvatarTypeSmall,// 小头像
    kAvatarTypeDefault,// 默认头像
    kAvatarTypeBig// 大头像
} AvatarType;

@class User;

@interface AvatarView : UIView

// 用户
@property (nonatomic,strong,readonly) User *user;
// 头像类型
@property (nonatomic,assign,readonly) AvatarType avatarType;
// 将用户模型和头像类型传递过去
-(void)setUser:(User *)user avatarType:(AvatarType)avatarType;

// 根据AvatarView的类型来获取AvatarView的大小
+(CGSize)avatarViewWithType:(AvatarType)avatarType;

@end
