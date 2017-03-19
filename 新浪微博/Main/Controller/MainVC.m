//
//  MainVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "MainVC.h"
#import "TabBar.h"
#import "ZFConst.h"

#import "HomeVC.h"
#import "MessageVC.h"
#import "ProfileVC.h"
#import "DiscoverVC.h"
#import "MoreVC.h"

#import "UINavigationItem+Helper.h"

#import "NavigationVC.h"


@interface MainVC ()

@end

@implementation MainVC

single_implementation(MainVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1、添加子控制器
    [self addChildViewControllers];
    
    // 2、获得第0个控制器的navigationItem
    [self.navigationItem copyNavigationItemFromOtherVCNavigationItem:self.childViewControllers[0].navigationItem];
}

-(void)viewWillAppear:(BOOL)animated
{
    // 1、添加tabBar
    [self addTabBar];
}

#pragma mark - 添加tabBar
-(void)addTabBar
{
    // 1、添加自定义的tabBar，只执行一次就行了
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.tabBar removeFromSuperview];
        
        TabBar *tabBar = [[TabBar alloc] init];
        tabBar.frame = self.tabBar.frame;
        [self.view addSubview:tabBar];
        
        // 2、创建tabBar上的按钮
        NSArray *iconNameArray = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_profile",@"tabbar_discover",@"tabbar_more"];
        NSArray *titleArray = @[@"首页",@"消息",@"我",@"发现",@"更多"];
        
        NSUInteger tabBarButtonCount = iconNameArray.count;
        
        for (NSUInteger i = 0; i < tabBarButtonCount; i++) {
            [tabBar addTabBarButtonWithNormalIcon:iconNameArray[i] title:titleArray[i]];
        }
        
        // 3、实现tabBar的tabBarButtonDidSelectBlock
//        __block __weak typeof(self) weakSelf = self;
        kWeakSelf;
        tabBar.tabBarButtonDidSelectBlock = ^(NSUInteger from, NSUInteger to){
            if ((int)to < 0 || to >= tabBar.subviews.count) return;
            [weakSelf tabBarButtonDidSelectFrom:from to:to];
        };
    });
}

#pragma mark - 添加子控制器
-(void)addChildViewControllers
{
    HomeVC *homeVC = [[HomeVC alloc] init];
    MessageVC *messageVC = [[MessageVC alloc] init];
    ProfileVC *profileVC = [[ProfileVC alloc] init];
    DiscoverVC *discoverVC = [[DiscoverVC alloc] init];
    MoreVC *moreVC = [[MoreVC alloc] init];
    
    self.viewControllers = @[homeVC,messageVC,profileVC,discoverVC,moreVC];
}

#pragma mark - 更新被选中的控制器
-(void)tabBarButtonDidSelectFrom:(NSUInteger)from to:(NSUInteger)to
{
    // 切换被选中的控制器
    self.selectedIndex = to;
    // 更新navigationItem
    [self.navigationItem copyNavigationItemFromOtherVCNavigationItem:self.childViewControllers[to].navigationItem];
}

#pragma mark - 显示回来状态栏
-(BOOL)prefersStatusBarHidden
{
    return NO;
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
