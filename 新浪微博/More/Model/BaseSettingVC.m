//
//  BaseSettingVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseSettingVC.h"
#import "SettingCell.h"

@interface BaseSettingVC ()

@property (nonatomic,strong) UIView *tableViewBackgroundView;

@end

@implementation BaseSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.tableView.sectionHeaderHeight = 15;
//    self.tableView.sectionFooterHeight = 0;
}

-(NSMutableArray *)sections
{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    
    return _sections;
}

//// 实例化tableView背景视图
//-(UIView *)tableViewBackgroundView
//{
//    if (_tableViewBackgroundView == nil) {
//        _tableViewBackgroundView = [[UIView alloc] initWithFrame:kScreenFrame];
//    }
//    
//    return _tableViewBackgroundView;
//}

#pragma mark - 加载view
// 修改tableViewController的tableView，使用代码创建、修改控制器的view，放在-loadView中进行，该方法专门用来加载控制器视图。该视图被加载完毕，就会接着调用-viewDidLoad方法，再去在该视图上addSubview其他控件。顺序不可乱。
-(void)loadView
{
    // 尺寸、样式：分组样式，可以去除多余的cell
    self.tableView = [[UITableView alloc] initWithFrame:kScreenFrame style:UITableViewStyleGrouped];
    //    self.tableView.style = UITableViewStyleGrouped;// UITableView的style是个只读属性，不能被修改。所以只能采用[[UITableView alloc] initWithFrame:kScreenFrame style:UITableViewStyleGrouped];的方法来重新设置self.tableView的大小、尺寸和样式（其实只是为了设置样式）。
    
    // 清空tableView默认的背景视图
//    self.tableView.backgroundView = nil;
    // 设置tableViewBackgroundView的背景颜色
//    self.tableViewBackgroundView.backgroundColor = kGlobalBg;
    // 设置tableView的背景视图为tableViewBackgroundView
//    self.tableView.backgroundView = self.tableViewBackgroundView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 在sections获取section对应的那个组
    SettingCellSection *singleSection = self.sections[section];
    return singleSection.settingCellContents.count;// settingCellContents盛装着那个设置控制器中该组中每行cell所对应的settingCellContent，在对应的控制器中，有多少个cell，就应该设置多少个settingCellContent，所以settingCellContents的个数就是该组中cell的个数
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    SettingCellSection *section = self.sections[indexPath.section];
    
    SettingCell *settingCell = [SettingCell settingCellWithTableView:tableView settingCellContent:section.settingCellContents[indexPath.row]];
    
    settingCell.indexPath = indexPath;
    settingCell.section = section.settingCellContents;
    
    return settingCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 先取消被选中的那一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出该行cell对应的模型数据（先要在sections中获取该行cell所在的组，再在该组中获取该行cell对应的模型数据）
    SettingCellSection *section = self.sections[indexPath.section];
    SettingCellContent *settingCellContent = section.settingCellContents[indexPath.row];
    
    // 若该行cell对应的模型数据有block代码，就执行
    if (settingCellContent.settingCellClickedBlock) {
        settingCellContent.settingCellClickedBlock(settingCellContent);
        return;
    }else if (settingCellContent.showVCClass){
        UIViewController *vc = [[settingCellContent.showVCClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingCellSection *singleSection = self.sections[section];
    return singleSection.header;
}

#pragma mark - 尾标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingCellSection *singleSection = self.sections[section];
    return singleSection.footer;
}

#pragma mark - 组标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SettingCellSection *singleSection = self.sections[section];
    return singleSection.headerHeight;
}

#pragma mark - 尾标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SettingCellSection *singleSection = self.sections[section];
    return singleSection.footerHeight;
}

//#pragma mark - 解决iOS7中，tableView设置UITableViewStyleGrouped后的section之间空余问题
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 15;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
