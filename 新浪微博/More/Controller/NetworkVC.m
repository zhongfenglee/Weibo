//
//  NetworkVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/25.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NetworkVC.h"
#import "UIBarButtonItem+Helper.h"

#import "TabBarButton.h"
#import "TabBar.h"
#import "UIImage+Helper.h"

@interface NetworkVC () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UIButton *reloadButton;

@end

@implementation NetworkVC

-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:kScreenFrame];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    
    return _webView;
}

-(UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
    }
    
    return _activityIndicator;
}

-(UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.center = CGPointMake(self.view.bounds.size.width * 0.5, 80);
        _label.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 44);
        _label.text = @"网页由weibo.cn提供";
        _label.textColor = LeeColor(127,127,127,1.0);
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"empty_failed"];
        _imageView.center = CGPointMake(self.label.center.x, self.view.bounds.size.height * 0.5);
        CGSize size = _imageView.image.size;
        _imageView.bounds = (CGRect){CGPointZero,size};
    }
    
    return _imageView;
}

-(UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] init];
        _label1.center = CGPointMake(self.imageView.center.x,  20 + CGRectGetMaxY(self.imageView.frame));
        _label1.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        _label1.text = @"网络出错啦，请点击按钮重新加载";
        _label1.textColor = LeeColor(127,127,127,1.0);
        _label1.font = [UIFont systemFontOfSize:15];
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label1;
}

-(UIButton *)reloadButton
{
    if (_reloadButton == nil) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadButton setBackgroundImage:[UIImage stretchImageWithImageName:@"empty_button"] forState:UIControlStateNormal];
        [_reloadButton setBackgroundImage:[UIImage stretchImageWithImageName:@"empty_button_highlighted"] forState:UIControlStateHighlighted];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:LeeColor(76,76,76,1.0) forState:UIControlStateNormal];
        _reloadButton.center = CGPointMake(self.label1.center.x, 20 + CGRectGetMaxY(self.label1.frame));
        _reloadButton.bounds = CGRectMake(0, 0, 150, 44);
        [_reloadButton addTarget:self action:@selector(reload1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _reloadButton;
}

-(void)loadView
{
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
//    self.title = @"微博服务使用协议";
    self.title = self.netTitle;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImage:@"toolbar_more" target:self action:@selector(showActionSheet)];
    
    [self.view addSubview:self.activityIndicator];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self reload1];
}

-(void)showActionSheet
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __block __weak typeof (self) weakSelf = self;
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakSelf.webView reload];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
        [weakSelf reload1];
    }];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"浏览器打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        if ([kApplication canOpenURL:url]) {
            [kApplication openURL:url];
        }
    }];
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [kTabBar tabBarButtonDidSelect:kTabBar.subviews[0]];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    UIAlertAction *alertAction4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];
    [alertController addAction:alertAction3];
    [alertController addAction:alertAction4];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - webView开始加载的时候调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // 指示器开始动画
//    [self.activityIndicator startAnimating];
}

#pragma mark - webView加载结束的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.activityIndicator isAnimating]) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidesWhenStopped = YES;
    }
    
    self.label.hidden = self.imageView.hidden = self.label1.hidden = self.reloadButton.hidden = YES;
    [self.label removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.label1 removeFromSuperview];
    [self.reloadButton removeFromSuperview];
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
//{
//    if (!error) return;
//    
//    if ([self.activityIndicator isAnimating]) {
//        [self.activityIndicator stopAnimating];
//        self.activityIndicator.hidesWhenStopped = YES;
//    }
//    self.title = @"找不到网页";
//    
////    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
////    [self.webView loadRequest:request];
//    
//    // 这句代码会引起webView加载部分网站时崩溃
////    [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
//    
//    self.label.hidden = self.imageView.hidden = self.label1.hidden = self.reloadButton.hidden = NO;
//    
//    [self.view addSubview:self.label];
//    [self.view addSubview:self.imageView];
//    [self.view addSubview:self.label1];
//    [self.view addSubview:self.reloadButton];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.activityIndicator startAnimating];
    return YES;
}

-(void)reload1
{
//    [self.activityIndicator startAnimating];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.activityIndicator stopAnimating];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
//    });
//    if (![self.activityIndicator isAnimating]) {
//        [self.activityIndicator startAnimating];
//    }
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
     NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
     [self.webView loadRequest:urlRequest];
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
