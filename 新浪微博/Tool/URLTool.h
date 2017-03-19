//
//  URLTool.h
//  新浪微博
//
//  Created by zhongfeng1 on 16/8/16.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLTool : NSObject

typedef void(^URLSuccess)(NSString *URLString);
typedef void(^URLFailure)(NSError *error);

+(void)URLShortToLong:(NSString *)URLStringShort URLSuccess:(URLSuccess)URLSuccess URLFailure:(URLFailure)URLFailure;

+(NSString *)URLShortToLong:(NSString *)URLStringShort;

@end
