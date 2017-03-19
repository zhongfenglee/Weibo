//
//  SettingVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "SettingVC.h"
//#import "SettingCellContent.h"
//#import "SettingCellSection.h"

#import "NoticeVC.h"
#import "PrivacySecurityVC.h"
#import "GeneralSettingVC.h"
#import "AboutVC.h"
#import "AccountManageVC.h"
#import "FeedbackVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *morePlistPath = [[NSBundle mainBundle] pathForResource:@"More.plist" ofType:nil];
    self.title = @"设置";
    
    [self addFirstSection];
    [self addSecondSection];
    [self addThirdSection];
    [self addFourthSection];
    [self addFifthSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"账号管理" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[AccountManageVC class]];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent]headerHeight:20.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"通知" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[NoticeVC class]];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"隐私与安全" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[PrivacySecurityVC class]];
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"通用设置" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[GeneralSettingVC class]];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] headerHeight:3.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addThirdSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"意见反馈" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[FeedbackVC class]];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"关于微博" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[AboutVC class]];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:3.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addFourthSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"夜间模式" settingcellContentType:SettingCellContentTypeSwitch key:@"nightMode"];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"清除缓存" settingcellContentType:SettingCellContentTypeLabelAndDisclosureIndicator key:@"clearCache"];
//    if (settingCellContent2.subTitle.length == 0) {
//        settingCellContent2.subTitle = @"0.0MB";
//    }
    __block __typeof(self) weakSelf = self;
//    kWeakSelf;
    settingCellContent2.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定清除缓存吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:3.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addFifthSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"退出微博" settingcellContentType:SettingCellContentTypeNone];
    __block __typeof(self) weakSelf = self;
//    kWeakSelf;
    settingCellContent1.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出微博？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {// 点击alertController上的确定按钮，退出微博
            [UIView animateWithDuration:0.7f animations:^{
                kKeyWindow.alpha = 0.0;
                kKeyWindow.frame = CGRectMake(0, kScreenHeight * 0.5, kScreenWidth, 0);
            } completion:^(BOOL finished) {
                exit(0);
            }];
        }];

        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:3.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:15.0f footerHeight:0.01f];
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
