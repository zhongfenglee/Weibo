//
//  BaseStatus.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseModel.h"

@class User;

@interface BaseStatus : BaseModel

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSMutableAttributedString *attStrM;
// 微博来源
@property (nonatomic,copy) NSString *source;
@property (nonatomic,strong) User *user;

@end
