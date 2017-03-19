//
//  StatusRepostCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusRepostCell.h"
#import "StatusRepostCellFrame.h"

@interface StatusRepostCell ()

@property (nonatomic,strong) StatusRepostCellFrame *statusRepostCellFrame;

@end

@implementation StatusRepostCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)statusRepostCellWithTableView:(UITableView *)tableView statusRepostCellFrame:(StatusRepostCellFrame *)statusRepostCellFrame
{
    static NSString *cellID = @"statusRepostCell";
    
    StatusRepostCell *statusRepostCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (statusRepostCell == nil) {
        statusRepostCell = [[StatusRepostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //        statusCommentCell.backgroundColor = kGlobalColor;
    }
    
    statusRepostCell.statusRepostCellFrame = statusRepostCellFrame;
    
    return statusRepostCell;
}

-(void)setStatusRepostCellFrame:(StatusRepostCellFrame *)statusRepostCellFrame
{
    _statusRepostCellFrame = statusRepostCellFrame;
    
    [super setBaseStatusCommentRepostLikeCellFrame:statusRepostCellFrame];
}

@end
