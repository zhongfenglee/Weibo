//
//  NavigationVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NavigationVC.h"
#import "UIImage+Helper.h"
#import "UIBarButtonItem+Helper.h"
#import "MainVC.h"

@interface NavigationVC () <UINavigationControllerDelegate>

@end

@implementation NavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航控制器所管理的所有或部分（如除根控制器除外:MainVC）控制器的导航栏左边按钮都是箭头,必须遵循三个步骤：
    // 1、导航控制器必须遵守UINavigationControllerDelegate；2、必须设置导航控制器的代理；3、实现-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated方法
    self.delegate = self;
    
//    self.hidesBarsOnSwipe = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置UINavigationBar、UIBarButtonItem的外观
+(void)initialize
{
    // appearance方法返回一个导航栏的外观对象
    // 修改了appearance这个外观对象，相当于修改了整个项目中导航栏的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];// 导航条
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];// 导航条上的按钮
    
    // UINavigationBar的背景图片和文字属性
    [navigationBar setBackgroundImage:[UIImage stretchImageWithImageName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    // tintColor被用于改变导航栏上items和bar button items的文字颜色，如果items带文字，想改变文字颜色，可以用这一句；barTintColor被用于改变导航栏条的颜色
    navigationBar.tintColor = [UIColor redColor];
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowOffset = CGSizeZero;
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:LeeColor(76,76,76,1.0),NSFontAttributeName:kFont(17)}];
    
    // barButtonItem的背景图片和文字属性
//    [barButtonItem setBackgroundImage:[UIImage stretchImageWithImageName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barButtonItem setBackgroundImage:[UIImage stretchImageWithImageName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    NSDictionary *dict = @{NSForegroundColorAttributeName:LeeColor(76,76,76,1.0),NSFontAttributeName:kFont(15)};
    [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
}

#pragma mark - 导航控制器代理方法
#pragma mark 导航控制器即将展示新的控制器时，会掉用这个方法
// 要想使用该方法，必须1、控制器遵循UINavigationControllerDelegate；2、控制器代理必须为遵循UINavigationControllerDelegate控制器
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 将所有即将展示的控制器的leftBarButtonItem设置为左箭头
    // 获得导航控制器的根控制器(栈底控制器)
    UIViewController *rootVC = navigationController.viewControllers[0];
    
    if (viewController != rootVC) {// 如果即将展示的控制器不是导航控制器的根控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImage:@"navigationbar_back" target:self action:@selector(back)];
    }
}

-(void)back
{
    // 跳到上一级控制器,self就代表导航控制器NavigationVC
    [self popViewControllerAnimated:YES];
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
