//
//  AudioTool.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/7/29.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AudioTool.h"
//#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>// 要使用系统声音服务(systerm sound services)，首先要导入AudioToolbox.h

@implementation AudioTool

static NSMutableDictionary *_soundIDs;

+(NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    
    return _soundIDs;
}

#pragma mark - 创建音效
+(void)playSound:(NSString *)soundName
{
    if (!soundName) return;// 如果不存在音效文件，则下面的代码不执行
    SystemSoundID soundID = [self.soundIDs[soundName] unsignedIntValue];// 取出字典中对应soundName的键值(NSNumber类型的对象)，并转化成unsigned int类型的基本数据
    if (!soundID) {// 若soundID不存在，则表示传进来的是新的soundName，加载音效文件并创建音效ID
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        if (!soundURL) return;// 如果不存在URL，则不执行下面的代码
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundURL), &soundID);// 创建音效ID并付给soundID
        [self.soundIDs setObject:@(soundID) forKey:soundName];// 将新的音效ID加入到字典中
    }
    AudioServicesPlaySystemSound(soundID);// 播放音效
}

#pragma mark - 释放音效
+(void)disposeSound:(NSString *)soundName
{
    if (!soundName) return;// 如果传入的文件名为空，则到此为止
    SystemSoundID soundID = [self.soundIDs[soundName] unsignedIntValue];// 从字典中取出soundID
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);// 销毁soundID对应的音效
        [self.soundIDs removeObjectForKey:soundName];// 从字典移除soundName对应的soundID
    }
}



@end
