//
//  SettingCellStorager.m
//  网易彩票
//
//  Created by 李中峰 on 15/11/27.
//  Copyright © 2015年 李中峰. All rights reserved.
//

#import "Storager.h"

@implementation Storager

+(void)setObject:(id)value forKey:(NSString *)key
{
    [kUserDefaults setObject:value forKey:key];
    [kUserDefaults synchronize];
}

+(id)objectForKey:(NSString *)key
{
    return [kUserDefaults objectForKey:key];
}

+(void)setBool:(BOOL)value forKey:(NSString *)key
{
    [kUserDefaults setBool:value forKey:key];
    [kUserDefaults synchronize];
}

+(BOOL)boolForKey:(NSString *)key
{
    return [kUserDefaults boolForKey:key];
}

@end
