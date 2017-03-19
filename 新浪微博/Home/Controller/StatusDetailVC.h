//
//  StatusDetailVC.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/27.
//  Copyright © 2016年 李中峰. All rights reserved.
//  微博正文控制器

#import <UIKit/UIKit.h>

@class Status;

@interface StatusDetailVC : UITableViewController

@property (nonatomic,strong) Status *status;

@end
