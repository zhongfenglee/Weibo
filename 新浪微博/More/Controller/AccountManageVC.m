//
//  AccountManageVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AccountManageVC.h"

@interface AccountManageVC ()

@end

@implementation AccountManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户管理";
    
    [self addFirstSection];
    [self addSecondSection];
}

-(void)addFirstSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithIcon:@"avatar_default" title:@"昵称" settingcellContentType:SettingCellContentTypeNone];
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithIcon:@"accountmanage_add" title:@"添加帐号" settingcellContentType:SettingCellContentTypeNone];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2]headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
}

-(void)addSecondSection
{
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"退出当前账号" settingcellContentType:SettingCellContentTypeNone];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:3.0f footerHeight:0.0f];
    
    __block __typeof(self) weakSelf = self;
//    kWeakSelf;
    settingCellContent1.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出此账号？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1] headerHeight:15.0f footerHeight:0.01f];
    
    [self.sections addObject:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0? 60 : [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
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
