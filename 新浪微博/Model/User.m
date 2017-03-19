//
//  User.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.screenName = dict[@"screen_name"];// 昵称        
        self.profileImageUrl = dict[@"profile_image_url"];// 小图头像
        self.avatarHd = dict[@"avatar_hd"];// 高清头像
        self.avatarLarge = dict[@"avatar_large"];// 大图头像
        
//        self.verified = [dict[@"verified"] boolValue];// 是否认证
        self.verifiedType = [dict[@"verified_type"] intValue];// 认证类型
        
        self.mbType = [dict[@"mbtype"] intValue];// 会员类型
        self.mbRank = [dict[@"mbrank"] intValue];// 会员等级
    }
    
    return self;
}

@end
