//
//  HZWaitingView.h
//  HZPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZPhotoBrowserConfig.h"

typedef enum {
    HZWaitingViewModeLoopDiagram, // 环形
    HZWaitingViewModePieDiagram // 饼型
} HZWaitingViewMode;

@interface HZWaitingView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) HZWaitingViewMode mode;

@end
