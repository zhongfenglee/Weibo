//
//  SettingCellStorager.h
//  网易彩票
//
//  Created by 李中峰 on 15/11/27.
//  Copyright © 2015年 李中峰. All rights reserved.
//  存储cell上的内容的工具类

#import <Foundation/Foundation.h>

@interface Storager : NSObject

+(id)objectForKey:(NSString *)key;
+(void)setObject:(id)value forKey:(NSString *)key;

+(BOOL)boolForKey:(NSString *)key;
+(void)setBool:(BOOL)value forKey:(NSString *)key;

@end
