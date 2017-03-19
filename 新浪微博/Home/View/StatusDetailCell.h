//
//  StatusDetailCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//  微博详情的cell

#import "BaseStatusCell.h"

@class StatusDetailCellFrame;

@interface StatusDetailCell : BaseStatusCell

+(instancetype)statusDetailCellWithTableView:(UITableView *)tableView statusDetailCellFrame:(StatusDetailCellFrame *)statusDetailCellFrame;

@end
