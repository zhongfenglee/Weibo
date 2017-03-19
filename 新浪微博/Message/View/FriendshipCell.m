//
//  FriendshipCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/6/3.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "FriendshipCell.h"
#import "User.h"
#import "HttpTool.h"

@implementation FriendshipCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.layer.cornerRadius = 25;
        self.imageView.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)friendshipCellWithTableView:(UITableView *)tableView user:(User *)user
{
    static NSString *friendshipCellID = @"friendshipCell";
    
    FriendshipCell *friendshipCell = [tableView dequeueReusableCellWithIdentifier:friendshipCellID];
    
    if (friendshipCell == nil) {
        friendshipCell = [[FriendshipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:friendshipCellID];
    }
    
    [HttpTool downLoadImageWithURL:user.profileImageUrl imageView:friendshipCell.imageView placeholder:[UIImage imageNamed:@"avatar_default"]];
    
    friendshipCell.textLabel.text = user.screenName;
    
    return friendshipCell;
}

@end
