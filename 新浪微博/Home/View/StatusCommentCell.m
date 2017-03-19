//
//  StatusCommentCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusCommentCell.h"
#import "StatusCommentCellFrame.h"

@interface StatusCommentCell ()

@property (nonatomic,strong) StatusCommentCellFrame *statusCommentCellFrame;

@end

@implementation StatusCommentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)statusCommentCellWithTableView:(UITableView *)tableView statusCommentCellFrame:(StatusCommentCellFrame *)statusCommentCellFrame
{
    static NSString *cellID = @"statusCommentCell";
    
    StatusCommentCell *statusCommentCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (statusCommentCell == nil) {
        statusCommentCell = [[StatusCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    statusCommentCell.statusCommentCellFrame = statusCommentCellFrame;
    statusCommentCell.backgroundColor = LeeColor(250,250,250,1.0);
    
    return statusCommentCell;
}

-(void)setStatusCommentCellFrame:(StatusCommentCellFrame *)statusCommentCellFrame
{
    _statusCommentCellFrame = statusCommentCellFrame;
    
    [super setBaseStatusCommentRepostLikeCellFrame:statusCommentCellFrame];
}

@end
