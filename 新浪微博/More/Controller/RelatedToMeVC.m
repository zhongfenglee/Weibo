//
//  RelatedToMeVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "RelatedToMeVC.h"

@interface RelatedToMeVC ()

@end

@implementation RelatedToMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"@设置";
    
    [self addFirstSection];
    [self addSecondSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"所有人" settingcellContentType:SettingCellContentTypeNone];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"我关注的人" settingcellContentType:SettingCellContentTypeNone];
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"关闭" settingcellContentType:SettingCellContentTypeNone];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] header:@"我将收到这些人的@通知" footer:nil headerHeight:25.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3] header:@"我将收到这些人的@通知" footer:nil headerHeight:35.0f footerHeight:35.0f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithIcon:@"messagescenter_at" title:@"@我的"  settingcellContentType:SettingCellContentTypeNone];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] header:@"所有的人@我时，都将在消息首页进行数字提醒，并将在应用外推送通知" footer:nil headerHeight:30.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] header:@"所有的人@我时，都将在消息首页进行数字提醒，并将在应用外推送通知" footer:nil headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 1? 60 : [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
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
