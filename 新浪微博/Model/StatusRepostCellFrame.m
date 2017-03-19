//
//  StatusRepostCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusRepostCellFrame.h"
#import "Repost.h"

@implementation StatusRepostCellFrame

//-(void)setBaseStatus:(BaseStatus *)baseStatus
//{
//    [super setBaseStatus:baseStatus];
//}

-(void)setRepost:(Repost *)repost
{
    _repost = repost;
    [super setBaseStatus:repost];
}

@end
