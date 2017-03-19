//
//  Account.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "Account.h"

@implementation Account

// 必须实现NSCoding两个方法
#pragma mark - 归档的时候调用
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

#pragma mark - 读档的时候调用
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

+(instancetype)initWithAccessToken:(NSString *)accessToken uid:(NSString *)uid
{
    Account *account = [[self alloc] init];
    
    account.accessToken = accessToken;
    account.uid = uid;
    
    return account;
}

@end
