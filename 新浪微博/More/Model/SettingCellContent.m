//
//  SettingCellContent.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "SettingCellContent.h"
#import "Storager.h"

@implementation SettingCellContent

#pragma mark - 创建cellContent
+(instancetype)settingcellContentWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle settingcellContentType:(SettingCellContentType)settingcellContentType showVCClass:(Class)showVCClass key:(NSString *)key
{
    SettingCellContent *settingcellContent = [[self alloc] init];
    
    settingcellContent.icon = icon;
    settingcellContent.title = title;
    settingcellContent.subTitle = subTitle;
    settingcellContent.settingCellContentType = settingcellContentType;
    settingcellContent.showVCClass = showVCClass;
    settingcellContent.key = key;
    
    return settingcellContent;
}

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType showVCClass:(Class)showVCClass
{
    return [self settingcellContentWithIcon:nil title:title subTitle:nil settingcellContentType:settingcellContentType showVCClass:showVCClass key:nil];
}

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType key:(NSString *)key
{
    return [self settingcellContentWithIcon:nil title:title subTitle:nil settingcellContentType:settingcellContentType showVCClass:nil key:key];
}

+(instancetype)settingcellContentWithIcon:(NSString *)icon title:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType
{
    return [self settingcellContentWithIcon:icon title:title subTitle:nil settingcellContentType:settingcellContentType showVCClass:nil key:nil];
}

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType
{
    return [self settingcellContentWithIcon:nil title:title subTitle:nil settingcellContentType:settingcellContentType showVCClass:nil key:nil];
}


-(void)setOn:(BOOL)on
{
    if (_key.length == 0) return;
    _on = on;
    [Storager setBool:on forKey:_key];
    
    if (self.settingCellSwitchChangedBlock) {
        self.settingCellSwitchChangedBlock(self);
    }
}

-(void)setKey:(NSString *)key
{
    if (key.length == 0) return;
    _key = key;
    
//    @try {
//        _on = [Storager boolForKey:key];
//    }
//    @catch (NSException *exception) {
//        _subTitle = [Storager objectForKey:key];
//    }
    
    _on = [Storager boolForKey:key];
    _subTitle = [Storager objectForKey:key];
}

-(void)setSubTitle:(NSString *)subTitle
{
    if (_key.length == 0) return;
    _subTitle = subTitle;
    [Storager setObject:subTitle forKey:_key];
}

@end
