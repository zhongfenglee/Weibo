//
//  NoticeVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NoticeVC.h"
//#import "SettingCellContent.h"
//#import "SettingCellSection.h"
#import "RelatedToMeVC.h"

@interface NoticeVC ()

@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知";
    
    [self addFirstSection];
    [self addSecondSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"@我的" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:[RelatedToMeVC class]];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"评论" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"赞" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent4 = [SettingCellContent settingcellContentWithTitle:@"消息" settingcellContentType:SettingCellContentTypeSwitch key:@"message"];
    SettingCellContent *settingCellContent5 = [SettingCellContent settingcellContentWithTitle:@"群通知" settingcellContentType:SettingCellContentTypeSwitch key:@"groupNotice"];
    SettingCellContent *settingCellContent6 = [SettingCellContent settingcellContentWithTitle:@"未关注人消息" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent7 = [SettingCellContent settingcellContentWithTitle:@"新粉丝" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4,settingCellContent5,settingCellContent6,settingCellContent7]headerHeight:20.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4,settingCellContent5,settingCellContent6,settingCellContent7] headerHeight:15.0f footerHeight:30.0f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"好友圈微博" settingcellContentType:SettingCellContentTypeSwitch key:@"friendsGroupWeibo"];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"特别关注微博" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"群微博" settingcellContentType:SettingCellContentTypeSwitch key:@"groupWeibo"];
    SettingCellContent *settingCellContent4 = [SettingCellContent settingcellContentWithTitle:@"微博热点" settingcellContentType:SettingCellContentTypeSwitch key:@"WeiboHot"];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4] header:@"新微博推送通知" footer:nil headerHeight:20.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4] header:@"新微博推送通知" footer:nil headerHeight:5.0f footerHeight:0.01f];
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
