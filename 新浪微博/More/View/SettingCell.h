//
//  SettingCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingCellContent;

@interface SettingCell : UITableViewCell

@property (nonatomic,strong) SettingCellContent *settingCellContent;

@property (nonatomic,strong) NSArray *section;
@property (nonatomic,strong) NSIndexPath *indexPath;

+(instancetype)settingCellWithTableView:(UITableView *)tableView settingCellContent:(SettingCellContent *)settingCellContent;

@end
