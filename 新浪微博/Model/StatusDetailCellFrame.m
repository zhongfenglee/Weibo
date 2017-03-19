//
//  StatusDetailCellFrame.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"
#import "ZFConst.h"

@implementation StatusDetailCellFrame

-(void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    if (status.retweetedStatus) {
        CGRect frame = self.retweetedViewFrame;
        frame.size.height += kRetweetedStatusOptionBarHeight;
        self.retweetedViewFrame = frame;
        
        self.cellHeight += kRetweetedStatusOptionBarHeight;
    }
}

@end
