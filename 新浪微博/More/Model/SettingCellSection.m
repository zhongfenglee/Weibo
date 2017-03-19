//
//  SettingCellSection.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "SettingCellSection.h"

@implementation SettingCellSection

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents header:(NSString *)header footer:(NSString *)footer headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight
{
    SettingCellSection *settingCellSection = [[self alloc] init];
    
    settingCellSection.settingCellContents = settingCellContents;
    settingCellSection.header = header;
    settingCellSection.footer = footer;
    settingCellSection.headerHeight = headerHeight;
    settingCellSection.footerHeight = footerHeight;
    
    return settingCellSection;
}

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight
{
    return [self settingCellSectionWithsettingCellContents:settingCellContents header:nil footer:nil headerHeight:headerHeight footerHeight:footerHeight];
}

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents
{
    return [self settingCellSectionWithsettingCellContents:settingCellContents header:nil footer:nil headerHeight:0.0f footerHeight:0.0f];
}

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents header:(NSString *)header headerHeight:(CGFloat)headerHeight
{
    return [self settingCellSectionWithsettingCellContents:settingCellContents header:header footer:nil headerHeight:headerHeight footerHeight:0.0f];
}

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents footer:(NSString *)footer footerHeight:(CGFloat)footerHeight
{
    return [self settingCellSectionWithsettingCellContents:settingCellContents header:nil footer:footer headerHeight:0.0f footerHeight:footerHeight];
}



@end
