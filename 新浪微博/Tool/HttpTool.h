//
//  HttpTool.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/13.
//  Copyright © 2016年 李中峰. All rights reserved.
//  负责发送整个微博项目中的get／post请求

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SuccessBlock)(id JSON);
typedef void (^FailureBlock)(NSError *error);

@interface HttpTool : NSObject

+(void)AFN_GetWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)AFN_PostWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)NSURLSession_PostWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)downLoadImageWithURL:(NSString *)url imageView:(UIImageView *)imageView placeholder:(UIImage *)placeholder;

@end
