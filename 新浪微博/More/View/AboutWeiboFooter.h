//
//  AboutWeiboFooter.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/23.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutWeiboFooter : UIView

+(instancetype)aboutWeiboFooter;

@property (nonatomic,copy) void (^showHtml) (NSString *urlSting);

@end
