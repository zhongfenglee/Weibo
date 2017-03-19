//
//  TextView.m
//  新浪微博
//
//  Created by zhongfeng1 on 16/8/11.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "TextView.h"
#import "NetworkVC.h"
#import "UIView+Helper.h"

#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"

@interface TextView () <UITextViewDelegate>

@property (nonatomic,assign) NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation TextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        self.scrollEnabled = NO;
        self.selectable = YES;
        self.dataDetectorTypes = UIDataDetectorTypeAll;
        self.backgroundColor = [UIColor clearColor];
                
        float lineFragmentPadding = [self.textContainer lineFragmentPadding];
        NSLog(@"%p, lineFragmentPadding: %f",self.textContainer,lineFragmentPadding);
        
//        NSLog(@"textContainerInset: %@",NSStringFromUIEdgeInsets(self.textContainerInset));
        
        // 解决textView显示文字不全的问题（用boundingRectWithSize方法后，再赋给textView的frame后会出现textView的rect小于文字的rect的现象。。。）
//        self.layoutManager.allowsNonContiguousLayout = NO;
//        [self setContentInset:UIEdgeInsetsMake(-5, -5, -10, 10)];//设置UITextView的内边距
//        self.contentInset = UIEdgeInsetsMake(-8,0,0,0);
        self.textContainerInset = UIEdgeInsetsZero;
        self.textContainer.lineFragmentPadding = 0;
        
        self.delegate = self;
    }
    
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    __block NSString *URLStringLong = nil;
    //跳转到内置webView
    NetworkVC *networkVC = [[NetworkVC alloc] init];
    
    NSString *name = nil;
    for (int i = 0; i <= 1; i++) {
        name = @"lizhongfeng";
        NSLog(@"for循环内的name: %@",name);
    }
    
    NSLog(@"for循环外的name: %@",name);

    __block __typeof(self) weakSelf = self;
    [HttpTool AFN_GetWithURLString:kShort_url_expand params:@{@"access_token":kAccessToken,@"url_short":URL.absoluteString} success:^(id JSON) {
        NSArray *URLArray = JSON[@"urls"];
//
//        [URLArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *URLStringShort = obj[@"url_short"];
//            NSString *URLStringLong = obj[@"url_long"];
//            networkVC.urlString = URLStringLong;
//        }];
        
//        NSString *URLStringLong = JSON[@"urls"][@"url_long"];
//        networkVC.urlString = URLStringLong;
//        NSLog(@"URLStringLong: %@",URLStringLong);
        
        for (NSDictionary *URLDict in URLArray) {
            URLStringLong = URLDict[@"url_long"];
            NSLog(@"for循环内的URLStringLong: %@",URLStringLong);
        }
        NSLog(@"block内的URLStringLong: %@",URLStringLong);
        
        networkVC.urlString = URLStringLong;
        networkVC.netTitle = weakSelf.text;
        [[weakSelf getCurrentViewController].navigationController pushViewController:networkVC animated:YES];
    } failure:^(NSError *error) {
        
    }];
    
    NSLog(@"for循环外的URLStringLong: %@",URLStringLong);
    
    return NO;
}

//-(void)URLStringShortToURLStringLong:(NSString *)URLStringShort
//{
//    [HttpTool AFN_GetWithURLString:kShort_url_expand params:@{@"access_token":kAccessToken,@"url_short":URLStringShort} success:^(id JSON) {
//        NSArray *array = JSON[@"urls"];
//        NSLog(@"%@",array);
//        
//        NSString *URLStringShort = JSON[@"urls"][@"url_short"];
//        NSString *URLStringLong = JSON[@"urls"][@"url_long"];
//        
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
//    
//}

//-(void)setFrame:(CGRect)frame {
////    self.contentSize = frame.size;
////    frame.origin.x = 0;
////    frame.size.width = kScreenWidth;
////    frame.size.height += 16;
////    [self sizeThatFits:frame.size];
//     CGSize sizeToFit = [self sizeThatFits:CGSizeMake(frame.size.width, MAXFLOAT)];
//    frame.size.height = sizeToFit.height;
//    [super setFrame:frame];
//}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height + 16);
//    textView.frame = newFrame;
//}

//-(void)setContentSize:(CGSize)contentSize
//{
//    CGSize size = (CGSize){contentSize.width, contentSize.height + 16};
//    self.bounds = (CGRect){CGPointZero,size};
//    
//    [super setContentSize:contentSize];
//}

//+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width {
//    UITextView *detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
//    
//    detailTextView.font = [UIFont systemFontOfSize:fontSize];
//    detailTextView.text = value;
//    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
//    
//    return deSize.height;
//}
//
//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *)strText
//{    float fPadding = 16.0; // 8.0px x 2
//    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
//    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    float fHeight = size.height + 16.0;
//    return fHeight;
//}

@end
