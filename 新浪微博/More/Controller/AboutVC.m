//
//  AboutVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AboutVC.h"
//#import "SettingCellContent.h"
//#import "SettingCellSection.h"
#import "AboutWeiboFooter.h"
#import "NetworkVC.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于微博";
    
    [self addTableHeaderView];
    
    [self addTableFooterView];
    
    [self addFirstSection];
}

-(void)addTableHeaderView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.2)];
    imageView.image = [UIImage imageNamed:@"visitordiscover_signup_logo"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.tableView.tableHeaderView = imageView;
}

-(void)addTableFooterView
{
    AboutWeiboFooter *aboutWeiboFooter = [AboutWeiboFooter aboutWeiboFooter];
    aboutWeiboFooter.center = CGPointMake(kScreenWidth * 0.5, self.tableView.tableFooterView.frame.origin.y);
    self.tableView.tableFooterView = aboutWeiboFooter;
    
//    __block __weak typeof (self) weakSelf = self;
    kWeakSelf;
    aboutWeiboFooter.showHtml = ^(NSString *urlString){
        NetworkVC *networkVC = [[NetworkVC alloc] init];
        networkVC.urlString = urlString;
        networkVC.netTitle = @"微博服务使用协议";
        [weakSelf.navigationController pushViewController:networkVC animated:YES];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addFirstSection
{
    // 给我评分
    SettingCellContent *settingCellContent1 = [SettingCellContent settingcellContentWithTitle:@"给我评分" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    settingCellContent1.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){// 评分支持：打开weibo在appStore上的地址
        NSURL *weiboUrlOnAppStore = [NSURL URLWithString:@"http://app.mi.com/detail/1127?ref=search"];
        if ([kApplication canOpenURL:weiboUrlOnAppStore]) {
            [kApplication openURL:weiboUrlOnAppStore];
        }
    };
    
    // 官方微博
    SettingCellContent *settingCellContent2 = [SettingCellContent settingcellContentWithTitle:@"官方微博" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    __block __weak typeof (self) weakSelf = self;
    kWeakSelf;
    settingCellContent2.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){
        NetworkVC *networkVC = [[NetworkVC alloc] init];
        networkVC.urlString = @"http://weibo.com/58351?refer_flag=1001030101_&is_hot=1";
        networkVC.netTitle = @"微博iPhone客户端";
        [weakSelf.navigationController pushViewController:networkVC animated:YES];
//        weakSelf.navigationController.navigationBarHidden = YES;
    };
    
    // 常见问题
    SettingCellContent *settingCellContent3 = [SettingCellContent settingcellContentWithTitle:@"常见问题" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
    settingCellContent3.settingCellClickedBlock = ^(SettingCellContent *settingCellContent){
        NetworkVC *networkVC = [[NetworkVC alloc] init];
        networkVC.urlString = @"http://help.weibo.com/faq/q/151";
        networkVC.netTitle = @"常见问题";
        [weakSelf.navigationController pushViewController:networkVC animated:YES];
    };
    
    // 版本更新
    SettingCellContent *settingCellContent4 = [SettingCellContent settingcellContentWithTitle:@"版本更新" settingcellContentType:SettingCellContentTypeDisclosureIndicator showVCClass:nil];
//    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4] headerHeight:10.0f footerHeight:0.0f];
    SettingCellSection *section = [SettingCellSection settingCellSectionWithsettingCellContents:@[settingCellContent1,settingCellContent2,settingCellContent3,settingCellContent4] headerHeight:15.0f footerHeight:0.01f];
    [self.sections addObject:section];
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
