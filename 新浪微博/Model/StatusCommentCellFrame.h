//
//  StatusCommentCellFrame.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatusCommentRepostLikeCellFrame.h"

@class Comment;

@interface StatusCommentCellFrame : BaseStatusCommentRepostLikeCellFrame

@property (nonatomic,strong) Comment *comment;

@end
