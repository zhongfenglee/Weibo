//
//  TableViewCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//  展示一条微博

#import "BaseStatusCell.h"

@class HomeCellFrame;

@interface HomeCell : BaseStatusCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView homeCellFrame:(HomeCellFrame *)homeCellFrame;

@end
