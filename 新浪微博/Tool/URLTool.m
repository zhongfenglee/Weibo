//
//  URLTool.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/8/16.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "URLTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"

@implementation URLTool

+(void)URLShortToLong:(NSString *)URLStringShort URLSuccess:(URLSuccess)URLSuccess URLFailure:(URLFailure)URLFailure
{
    [HttpTool AFN_GetWithURLString:kShort_url_expand params:@{@"access_token":kAccessToken,@"url_short":URLStringShort} success:^(id JSON) {
        NSArray *array = JSON[@"urls"];
        //                NSLog(@"%@",array);
        
        NSString *URLStringShort = nil;
        NSString *URLStringLong = nil;
        for (NSDictionary *URLDict in array) {
            URLStringShort = URLDict[@"url_short"];
            URLStringLong = URLDict[@"url_long"];
        }
        
        if (URLSuccess == nil) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            URLSuccess(URLStringLong);
        });
    } failure:^(NSError *error) {
        if (URLFailure == nil) return;
        URLFailure(error);
    }];
}

@end
