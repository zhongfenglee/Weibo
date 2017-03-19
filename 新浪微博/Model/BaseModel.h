//
//  BaseModel.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,assign) int64_t ID;
@property (nonatomic,copy) NSString *createdAt;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
