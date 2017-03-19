//
//  AccountTool.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//  负责管理账号（存储／读取账号）

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class Account;

@interface AccountTool : NSObject

single_interface(AccountTool)

// 帐号
@property (nonatomic,readonly) Account *account;

// 保存账号
-(void)saveAccount:(Account *)account;

@end
