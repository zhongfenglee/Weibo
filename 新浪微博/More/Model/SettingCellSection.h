//
//  SettingCellSection.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SettingCellSection : NSObject

@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,strong) NSArray *settingCellContents;
@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents header:(NSString *)header footer:(NSString *)footer headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents;

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents header:(NSString *)header headerHeight:(CGFloat)headerHeight;

+(instancetype)settingCellSectionWithsettingCellContents:(NSArray *)settingCellContents footer:(NSString *)footer footerHeight:(CGFloat)footerHeight;

@end
