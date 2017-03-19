//
//  SettingCellContent.h
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingCellContent : NSObject

typedef enum{
    SettingCellContentTypeNone,// 右边什么都没有
    SettingCellContentTypeDisclosureIndicator,// 右边有个箭头
    SettingCellContentTypeLabelAndDisclosureIndicator,// 右边有个标签加箭头
    SettingCellContentTypeSwitch// 右边有个UISwitch
} SettingCellContentType;

@property (nonatomic,assign) SettingCellContentType settingCellContentType;

@property (nonatomic,copy) NSString *icon;// 图标
@property (nonatomic,copy) NSString *title;// 标题
@property (nonatomic,copy) NSString *subTitle;// 子标题
@property (nonatomic,assign) Class showVCClass;// 展现的控制器
@property (nonatomic,copy) NSString *key;// 存储时的键值

@property (nonatomic,assign,getter=isOn) BOOL on;

@property (nonatomic,copy) void (^settingCellClickedBlock)(SettingCellContent *settingCellContent);
@property (nonatomic,copy) void (^settingCellSwitchChangedBlock)(SettingCellContent *settingCellContent);

+(instancetype)settingcellContentWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle settingcellContentType:(SettingCellContentType)settingcellContentType showVCClass:(Class)showVCClass key:(NSString *)key;

+(instancetype)settingcellContentWithIcon:(NSString *)icon title:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType;

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType showVCClass:(Class)showVCClass;

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType key:(NSString *)key;

+(instancetype)settingcellContentWithTitle:(NSString *)title settingcellContentType:(SettingCellContentType)settingcellContentType;

@end
