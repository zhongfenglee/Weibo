//
//  GeneralSettingVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "GeneralSettingVC.h"
//#import "SettingCellContent.h"
//#import "SettingCellSection.h"

@interface GeneralSettingVC ()

@end

@implementation GeneralSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通用设置";
    
    [self addFirstSection];
    [self addSecondSection];
    [self addThirdSection];
    [self addFourthSection];
    [self addFifthSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"阅读模式" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"字号设置" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"显示备注信息" settingcellContentType:SettingCellContentTypeSwitch key:@"showRemarkInfo"];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"开启快速拖动" settingcellContentType:SettingCellContentTypeSwitch key:@"unlockFastDrag"];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] header:nil footer:@"浏览列表时可使用拖动条快速拖动" headerHeight:15.0f footerHeight:30.0f];
    [self.sections addObject:section];
}

-(void)addThirdSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"横竖屏自动切换" settingcellContentType:SettingCellContentTypeSwitch key:@"landScapePortraitAutoSwitch"];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:3.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:10.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addFourthSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"图片浏览设置" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addFifthSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"声音与振动" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"多语言环境" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:15.0f footerHeight:0.01f];
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
