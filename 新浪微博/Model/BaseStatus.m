//
//  BaseStatus.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatus.h"
#import "User.h"
#import <UIKit/UIKit.h>
#import "NSString+Helper.h"
#import "NSMutableParagraphStyle+Helper.h"

//#import "HttpTool.h"
//#import "AccountTool.h"
//#import "Account.h"
#import "URLTool.h"

@interface BaseStatus ()

@property (nonatomic,strong) dispatch_queue_t concurrentPhotoQueue;

@end

@implementation BaseStatus

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        // 用户
        self.user = [[User alloc] initWithDict:dict[@"user"]];
        
        // 微博正文
        self.text = dict[@"text"];
        
//        [self getURLStringLong:dict[@"text"]];
        
        // 微博正文匹配处理
        self.attStrM = [self.text matchString];
        
        // 微博来源(获得dict[@"source"]后，由于点语法，接着就调用source的setter方法，截取字符串，重新设置获得来源名称)
        self.source = dict[@"source"];
    }
    
    return self;
}

#pragma mark - 重写source的setter方法，这个方法只会被调用一次
// 上面的字典解析为微博模型时，解析dict[@"source"]后接着就调用这个方法，截取出微博来源信息，重新设置给_source
-(void)setSource:(NSString *)source
{
    _source = source;
    
    // 如果新浪服务器返回的来源字符串为空字符串，则就不要执行下面的截取代码，否则会越界奔溃（找不到要查找的那个字符串的范围）
    if ([source isEqualToString:@""]) return;
    
    // 查找>和</的范围以截取二者之间的字符串
    NSUInteger begin = [_source rangeOfString:@">"].location + 1;
    NSUInteger end = [_source rangeOfString:@"</"].location;
    
    // 截取>和</之间的字符串，拼接“来自 ”，并重新设回给_source，这样_source就成为了“来自 xxx”
    _source = [@"来自 " stringByAppendingString:[_source substringWithRange:NSMakeRange(begin, end-begin)]] ;
}

/*
#pragma mark - 也可重写-setAttStrM:方法，来直接匹配字符串
-(void)setAttStrM:(NSMutableAttributedString *)attStrM
{
    _attStrM = attStrM;
    
    // 表情的规则
    //    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSString *emotionPattern = EMOTION_EXPRESSION;
    // @的规则
    //    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    NSString *atPattern = @"@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30}";
    //    NSString *atPattern = AT_EXPRESSION;
    // #话题#的规则
    //    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //    NSString *topicPattern = TOPIC_EXPRESSION;
    NSString *topicPattern = @"#[^#]+#";
    
    // url链接的规则
    //    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    //    NSString *urlPattern = URL_EXPRESSION;
    NSString *urlPattern = @"((ht|f)tp(s?):\\/\\/|www\\.)(([\\w\\-]+\\.){1,}?([\\w\\-.~]+\\/?)*[\\p{Alnum}.,%_=?&#\\-+()\\[\\]\\*$~@!:/{};']*)";
    
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    // 2.测试字符串
    NSRange range = NSMakeRange(0, self.text.length);
    NSArray *results = [regex matchesInString:self.text options:0 range:range];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle mutableParagraphStyleWithLineSpacing:kLineSpacing alignment:NSTextAlignmentJustified];
    [attStrM addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:range];
    for (NSTextCheckingResult *result in results) {
        [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(25,146,245,1)} range:result.range];
    }
    
    _attStrM = attStrM;
}
 */

//-(void)getURLStringLong:(NSString *)text
//{
//    NSError *error = nil;
//    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
//    
//    __block NSString *URLStringShort = nil;
//    __block __weak typeof (self) weakSelf = self;
//    [detector enumerateMatchesInString:text options:kNilOptions range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        if (result.URL){
//            URLStringShort = result.URL.absoluteString;
//            [URLTool URLShortToLong:URLStringShort URLSuccess:^(NSString *URLString) {
//                __strong __typeof(weakSelf)strongSelf = weakSelf;
//                NSLog(@"URLString: %@",URLString);
//                strongSelf.text = [text stringByReplacingOccurrencesOfString:URLStringShort withString:URLString];
//                NSLog(@"strongSelf.text:%@",strongSelf.text);
//            } URLFailure:^(NSError *error) {
//                
//            }];
//        }
//    }];
//}

//-(void)setText:(NSString *)text
//{
//    _text = text;
//    
//    NSError *error = nil;
//    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
//    
//    __block __weak typeof (self) weakSelf = self;
//    __block NSString *URLStringShort = nil;
//    [detector enumerateMatchesInString:text options:kNilOptions range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        if ((URLStringShort = result.URL.absoluteString).length){
//            [URLTool URLShortToLong:URLStringShort URLSuccess:^(NSString *URLString) {
//                __strong __typeof(weakSelf)strongSelf = weakSelf;
//                NSLog(@"URLString: %@",URLString);
//                strongSelf.text = [text stringByReplacingOccurrencesOfString:URLStringShort withString:URLString];
//                NSLog(@"strongSelf.text:%@",strongSelf.text);
//            } URLFailure:^(NSError *error) {
//                
//            }];
//        }
//    }];
//}

//-(NSString *)text
//{
//    NSError *error = nil;
//    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
//    
//    __block __weak typeof (self) weakSelf = self;
//    __block NSString *URLStringShort = nil;
//    [detector enumerateMatchesInString:_text options:kNilOptions range:NSMakeRange(0, _text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        if ((URLStringShort = result.URL.absoluteString).length){
//            [URLTool URLShortToLong:URLStringShort URLSuccess:^(NSString *URLString) {
//                __strong __typeof(weakSelf)strongSelf = weakSelf;
//                NSLog(@"URLString: %@",URLString);
//                strongSelf.text = [_text stringByReplacingOccurrencesOfString:URLStringShort withString:URLString];
//                NSLog(@"strongSelf.text:%@",strongSelf.text);
//            } URLFailure:^(NSError *error) {
//                
//            }];
//        }
//    }];
//    
//    return self.text;
//}

@end
