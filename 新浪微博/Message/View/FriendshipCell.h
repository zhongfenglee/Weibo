//
//  FriendshipCell.h
//  新浪微博
//
//  Created by 李中峰 on 16/6/3.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface FriendshipCell : UITableViewCell

+(instancetype)friendshipCellWithTableView:(UITableView *)tableView user:(User *)user;

@end
