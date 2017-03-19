//
//  NewfeatureVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/13.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NewfeatureVC.h"
#import "UIImage+Helper.h"
//#import "MainVC.h"
#import "ShareButton.h"
#import "ZFConst.h"

#import "UIButton+Helper.h"

#import "NavigationVC.h"

#import "OauthController.h"

@interface NewfeatureVC () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation NewfeatureVC

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        CGFloat scrollSizeWidth = self.view.bounds.size.width;
        _scrollView.contentSize = CGSizeMake(scrollSizeWidth * kNewfeatureImageCount, 0);
        _scrollView.pagingEnabled = YES;// 开启分页
        _scrollView.showsHorizontalScrollIndicator = NO;// 隐藏水平滚动条
        _scrollView.bounces = NO;// scrollView滚动到屏幕边缘不需要弹簧效果
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 450, 0)];// pageControl的高度是固定的36
        _pageControl.numberOfPages = kNewfeatureImageCount;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
        _pageControl.center = CGPointMake(kScreenWidth * 0.5, self.scrollView.frame.size.height * 0.96);
    }
    
    return _pageControl;
}

#pragma mark - 自定义view
-(void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = kScreenFrame;
    imageView.image = [UIImage fullScreenImage:@"new_feature_background.png"];
    imageView.userInteractionEnabled = YES;// 让imageView可以与用户交互，如果不加这一句(userInteractionEnabled默认为NO)，imageView无法将事件传递给scrollView，导致scrollView不能滚动
    self.view = imageView;
}

/*
 一个控件无法显示：
 1、没有设置宽高(或者宽高为｛0，0｝)
 2、位置不对
 3、hidden = YES
 */

/*
 一个UIScrollView无法滚动：
 1、contenSize没有值
 2、不能接收到触摸事件
 */

/*
 一个控件无法跟用户交互（无法接收事件）的可能原因：
 父控件或者自身的userInteractionEabled = NO;
 父控件或者自身的hidden = YES;
 父控件或者自身的alpha <= 0.01;
 父控件或者自身的背景是clearColor;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.添加UIScrollView
    [self.view addSubview:self.scrollView];
    
    CGSize scrollSize = self.scrollView.frame.size;
    
    // 2.添加图片
    for (int i = 0; i < kNewfeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_features_%d.png",i];
        imageView.frame = CGRectMake(i * scrollSize.width, 0, scrollSize.width, scrollSize.height);
        imageView.image = [UIImage fullScreenImage:name];
        [self.scrollView addSubview:imageView];
        
        if (i == kNewfeatureImageCount - 1) {// 最后一页
            // 添加“发微博分享给好友”            
            ShareButton *shareButton = [[ShareButton alloc] init];
            shareButton.center = CGPointMake(scrollSize.width * 0.5, scrollSize.height * 0.75);
            [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:shareButton];

            // 添加“立即体验”
            UIButton *startButton = [UIButton buttonWithBackgroundImage:@"new_feature_button" title:nil target:self action:@selector(start)];
            startButton.center = CGPointMake(shareButton.center.x, shareButton.center.y + 25);
            [imageView addSubview:startButton];
            imageView.userInteractionEnabled = YES;
        }
    }
    
    // 3.添加UIPageControl
    [self.view addSubview:self.pageControl];
}

#pragma mark - 滚动代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

#pragma mark - 监听“开始体验”按钮点击
// 用户点击“开始体验”按钮后，应从当前的“新特性控制器”跳转到“授权控制器”，进行账号/密码的输入以对应用进行授权
-(void)start
{
    MyLog(@"start");
    
    // OauthController依赖于NewfeatureVC跳转过来，在展现OauthController后应把NewfeatureVC释放掉，采用改变window的根控制器。一旦根控制器切换为新的控制器，原来那个旧的根控制器就会被释放掉。两种方法拿到程序的window：
//    [UIApplication sharedApplication].keyWindow;
//    self.view.window;
    OauthController *oauthController = [[OauthController alloc] init];
    kKeyWindow.rootViewController = [[NavigationVC alloc] initWithRootViewController:oauthController];
}

-(void)share:(UIButton *)sender
{
    MyLog(@"share");
    sender.selected = !sender.isSelected;
}

-(void)dealloc
{
    MyLog(@"newfeature被销毁");
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
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
