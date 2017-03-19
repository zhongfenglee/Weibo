//
//  FeedbackVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/22.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "FeedbackVC.h"
#import "UIBarButtonItem+Helper.h"

@interface FeedbackVC ()

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImage:@"feedback_send_button" title:@"发送" target:self action:@selector(send)];
}

-(void)loadView
{
    UITextView *textView = [[UITextView alloc] initWithFrame:kScreenFrame];
    textView.text = @"说点儿什么吧......";
    textView.textColor = LeeColor(127, 127, 127, 1.0);
    self.view = textView;
}

-(void)send
{
    NSLog(@"发送");
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
