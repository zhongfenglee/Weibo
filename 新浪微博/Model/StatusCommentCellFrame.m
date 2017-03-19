//
//  StatusCommentCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusCommentCellFrame.h"
#import "Comment.h"

@implementation StatusCommentCellFrame

//-(void)setBaseStatus:(BaseStatus *)baseStatus
//{
//    [super setBaseStatus:baseStatus];
//}

-(void)setComment:(Comment *)comment
{
    _comment = comment;
    
    [super setBaseStatus:comment];
}

@end
