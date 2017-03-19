//
//  Account.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//  账号

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>// 遵循NSCoding协议

// 属性
@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic,copy) NSString *uid;

// 初始化账号
+(instancetype)initWithAccessToken:(NSString *)accessToken uid:(NSString *)uid;

@end
