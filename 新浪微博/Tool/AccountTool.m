//
//  AccountTool.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

single_implementation(AccountTool)

-(id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    
    return self;
}

-(void)saveAccount:(Account *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

@end
