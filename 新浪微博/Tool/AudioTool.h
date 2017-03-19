//
//  AudioTool.h
//  新浪微博
//
//  Created by zhongfeng1 on 16/7/29.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTool : NSObject

// 播放音效
+(void)playSound:(NSString *)soundName;

// 销毁音效
+(void)disposeSound:(NSString *)soundName;

@end
