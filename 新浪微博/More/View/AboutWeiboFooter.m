//
//  AboutWeiboFooter.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/23.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AboutWeiboFooter.h"
#import "AboutVC.h"
#import "WebView.h"

@interface AboutWeiboFooter ()

@property (nonatomic,strong) WebView *webView;

@end

@implementation AboutWeiboFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(WebView *)webView
{
    if (_webView == nil) {
        _webView = [[WebView alloc] init];
    }
    
    return _webView;
}

+(instancetype)aboutWeiboFooter
{
    return [[NSBundle mainBundle] loadNibNamed:@"AboutWeiboFooter" owner:nil options:nil][0];;
}

- (IBAction)EnterpriseUserCall:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4000980980"]]];
}

- (IBAction)IndividualUserCall:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4000960960"]]];
}

- (IBAction)weiboServiceProtocol {
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.weibo.com/signup/v5/protocol"]]];
    NSString *urlString = @"http://www.weibo.com/signup/v5/protocol";
//    AboutVC *aboutVC = [[AboutVC alloc] init];
    if (self.showHtml) {
        self.showHtml(urlString);
    }
}

@end
