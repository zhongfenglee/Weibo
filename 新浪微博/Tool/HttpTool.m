//
//  HttpTool.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/13.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation HttpTool

#pragma mark - 利用AFN发送post请求
+(void)AFN_PostWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [[self creatAFHTTPSessionManager] POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return;
        failure(error);
    }];
}

#pragma mark - 利用AFN发送get请求
+(void)AFN_GetWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [[self creatAFHTTPSessionManager] GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return;
        failure(error);
    }];
}

#pragma mark - 利用苹果自带的NSURLSession发送post请求
+(void)NSURLSession_PostWithURLString:(NSString *)URLString params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    URLRequest.HTTPMethod = @"POST";
    URLRequest.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:URLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (success == nil) return;
        if (data != nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            success(dict);
        }else{
            if (failure == nil) return;
            failure(error);
        }
    }];
        
    [dataTask resume];
}

+(AFHTTPSessionManager *)creatAFHTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

#pragma mark - 利用SDWebImage下载图片
+(void)downLoadImageWithURL:(NSString *)url imageView:(UIImageView *)imageView placeholder:(UIImage *)placeholder
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageContinueInBackground|SDWebImageHighPriority];// 下载图片失败后重新下载，scrollview滑动的时候延迟下载（不会产生卡顿的感觉），允许后台下载，允许优先下载（默认情况下，图像按顺序被加载到队列中。这个标志将它们移到队列的前面，并立即加载，而不是等待当前队列加载（可能需要一段时间））
}

@end
