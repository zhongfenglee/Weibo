//
//  PrivacySecurityVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "PrivacySecurityVC.h"
//#import "SettingCellContent.h"
//#import "SettingCellSection.h"

@interface PrivacySecurityVC ()

@end

@implementation PrivacySecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐私与安全";
    
    [self addFirstSection];
    [self addSecondSection];
    [self addThirdSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"隐私设置" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"账号安全" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2]headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"已屏蔽消息的人" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"已屏蔽微博的人" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2]headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2]];
    [self.sections addObject:section];
}

-(void)addThirdSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"黑名单" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1]headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1]];
    [self.sections addObject:section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
