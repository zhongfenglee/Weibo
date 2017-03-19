//
//  Status.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//  微博模型

#import "BaseStatus.h"

@interface Status : BaseStatus

// 微博配图
@property (nonatomic,copy) NSString *thumbnailPic;// 小图
@property (nonatomic,copy) NSString *bmiddlePic;// 中图
@property (nonatomic,copy) NSString *originalPic;// 原图
@property (nonatomic,copy) NSArray *thumbnailPicUrls;// 配图的url数组

// 转发数
@property (nonatomic,assign) int repostsCount;
// 评论数
@property (nonatomic,assign) int commentsCount;
// 表态数(被赞数)
@property (nonatomic,assign) int attitudesCount;

// 转发微博
@property (nonatomic,strong) Status *retweetedStatus;

@end
