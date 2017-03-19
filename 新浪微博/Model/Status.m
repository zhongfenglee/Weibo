//
//  Status.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//  一条微博

#import "Status.h"
#import "User.h"

@implementation Status

#pragma mark - 解析字典为微博模型
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {        
//        // 原图（只能获得一张，因此如有多个配图，应使用thumbnailPicUrls）
        NSString *originalPic = dict[@"original_pic"];
        if (originalPic.length) {
            self.originalPic = originalPic;
            self.bmiddlePic = dict[@"bmiddle_pic"];
            self.thumbnailPic = dict[@"thumbnail_pic"];
        }
        
        // 微博配图url数组
        NSArray *thumbnailPicUrls = dict[@"pic_urls"];
        if (thumbnailPicUrls.count) {
            self.thumbnailPicUrls = thumbnailPicUrls;
        }
        
        // 转发微博
        NSDictionary *retweetedStatus = dict[@"retweeted_status"];
        if (retweetedStatus) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweetedStatus];
//            self.retweetedStatus.user.screenName = [@"@" stringByAppendingString:self.retweetedStatus.user.screenName];
        }
        
        // 转发数、评论数、表态数
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    
    return self;
}

 // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
// 重写source的getter方法，这个方法会被多次掉用
//-(NSString *)source
//{
//    MyLog(@"getter");
//    NSUInteger begin = [_source rangeOfString:@">"].location + 1;
//    NSUInteger end = [_source rangeOfString:@"</"].location;
//
//    return [@"来自 " stringByAppendingString:[_source substringWithRange:NSMakeRange(begin, end-begin)]] ;
//}

@end
