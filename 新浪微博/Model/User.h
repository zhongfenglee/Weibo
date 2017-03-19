//
//  User.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//  用户模型

#import "BaseModel.h"

// 认证类型
/*
 -1为没有经过认证的普通用户，200和220为达人用户，0为黄V用户，其它即为蓝V用户
 */
typedef enum {
    kVerifiedTypeNone = -1,// 没有认证的普通用户
    kVerifiedTypePerson = 0,// 个人认证
    kVerifiedTypeOrgEnterprice = 2,// 企业官方
    kVerifiedTypeNoneOrgMedia = 3,// 媒体官方
    kVerifiedTypeNoneOrgSchool = 4,// 校园
    kVerifiedTypeNoneOrgWebsite = 5,// 网站官方
    kVerifiedTypeNoneOrgApp = 6,// 应用
    kVerifiedTypeNoneOrgGroup = 7,// 团体（机构）
    kVerifiedTypeNoneOrgPending = 8,// 待审企业
    kVerifiedTypePrimerExpert = 200,// 初级微博达人
    kVerifiedTypeMiddleHighExpert = 220,// 中高级微博达人
    kVerifiedTypeDiedExpert = 400// 已故V用户
} VerifiedType;

typedef enum {
    kMBTypeNone = 0,// 不是会员
    kMBTypeMonth,// 普通会员
    kMBTypeYear,// 年费会员
} MBType;

//typedef enum {
//    kGenderMale,// 男性
//    kGenderfeMale// 女性
//} Gender;

@interface User : BaseModel

@property (nonatomic,copy) NSString *screenName;// 昵称

@property (nonatomic,copy) NSString *profileImageUrl;// 小头像
@property (nonatomic,copy) NSString *avatarLarge;// 大头像
@property (nonatomic,copy) NSString *avatarHd;// 高清头像

//@property (nonatomic,assign) Boolean verified;// 是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic,assign) VerifiedType verifiedType;// 认证类型

@property (nonatomic,assign) MBType mbType;// 会员类型
@property (nonatomic,assign) int mbRank;// 会员等级

@end
