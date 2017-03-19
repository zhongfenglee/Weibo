//
//  OauthController.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "OauthController.h"
#import "WebView.h"
#import "Account.h"
#import "AccountTool.h"
#import "NavigationVC.h"
#import "MainVC.h"
#import "MBProgressHUD.h"
#import "HttpTool.h"

@interface OauthController () <UIWebViewDelegate>

@property (nonatomic,strong) WebView *webView;

//@property (nonatomic, assign) BOOL canceled;

@end

@implementation OauthController

-(WebView *)webView
{
    if (_webView == nil) {
        _webView = [[WebView alloc] init];
        _webView.delegate = self;
    }
    
    return _webView;
}

-(void)loadView
{
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载登录页面（获取未授权的request token）
    NSString *oauthURLStr = [kOauthorize stringByAppendingFormat:@"&client_id=%@&redirect_uri=%@&display=mobile",kAppKey,kRedirectURI];
    NSURL *oauthURL = [NSURL URLWithString:oauthURLStr];
    NSURLRequest *oauthRequest = [NSURLRequest requestWithURL:oauthURL];
    
    [self.webView loadRequest:oauthRequest];
}

#pragma mark - 当webView开始加载请求就会调用
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"正在加载...";

    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        [weakSelf doSomeWorkWithProgress];
    });
}

- (void)doSomeWorkWithProgress {
    //    self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress <= 1.0f) {
        //        if (self.canceled) break;
        progress += 0.05f;
        __block __typeof(self)weakSelf = self;
//        kWeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:weakSelf.view].progress = progress;
        });
        usleep(50000);
    }
}

#pragma mark - 当webView完成加载请求就会调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 移除指示器
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.账号/密码输入页面：https://api.weibo.com/oauth2/authorize?&client_id=1816876941&redirect_uri=https://www.baidu.com&display=mobile
    // 2.授权页面(这个页面直接跳过，新浪微博开放平台并没有把登录和授权分开？？？)：https://api.weibo.com/oauth2/authorize
    // 3.返回requestToken：https://www.baidu.com/?code=709db5c6a8f4c69f1c0afbb7e5006839
    // 获得全路径
    NSString *urlStr = request.URL.absoluteString;

    // 查找code=范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        // 如果length不为0，说明已经跳到回调地址，说明授权成功了
        NSUInteger index = range.location + range.length;
        NSString *requestToken = [urlStr substringFromIndex:index];
        
        __block __typeof(self)weakSelf = self;
//        kWeakSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 用requestToken换取accessToken
            [weakSelf getAccessToken:requestToken];
        });
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 换取accessToken
-(void)getAccessToken:(NSString *)requestToken
{
///////////////////////////////////AFN无法请求到数据：bad request //////////////////////////////////////////////////////
    // 基准路径：协议头://主机名
//    NSDictionary *params = @{@"client_id":kAppKey,@"client_secret":kAppSecret,@"grant_type":@"authorization_code",@"code":requestToken,@"redirect_uri":kRedirectURI};
//
//    [HttpTool AFN_PostWithURLString:kOauthAccess params:params success:^(id JSON) {
//        // 保存账号信息
//        Account *account = [[Account alloc] init];
//        account.accessToken = JSON[@"access_token"];
//        account.uid = JSON[@"uid"];
//        [kAccountTool saveAccount:account];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 回到主页面
//            kKeyWindow.rootViewController = [[NavigationVC alloc] initWithRootViewController:kMainVC];
//        });
//    } failure:^(NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"加载数据失败，请稍后再试。" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
//            [alertController addAction:okAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        });
//    }];
    
////////////////////////////////////////只好用苹果自带的NSURLSession来请求数据/////////////////////////////////////////////
    NSString *params = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",kAppKey,kAppSecret,requestToken,kRedirectURI];

    [HttpTool NSURLSession_PostWithURLString:kOauthAccess params:params success:^(id JSON) {
        // 保存账号信息
        Account *account = [Account initWithAccessToken:JSON[@"access_token"] uid:JSON[@"uid"]];
        [kAccountTool saveAccount:account];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主页面
            kKeyWindow.rootViewController = [[NavigationVC alloc] initWithRootViewController:kMainVC];
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"加载数据失败，请稍后再试。" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 清除指示器
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
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
