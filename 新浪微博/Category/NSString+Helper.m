//
//  NSString+Helper.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/16.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "NSString+Helper.h"
#import <UIKit/UIKit.h>
#import "NSMutableParagraphStyle+Helper.h"

@implementation NSString (Helper)

#pragma mark - 用来拼接图片名
-(NSString *)fileNameAppend:(NSString *)append
{
    // 1.获取没有拓展名的文件名 (new_feature_background)
    NSString *fileName = [self stringByDeletingPathExtension];
    
    // 2.拼接字符串(-568h@2x、-667h@2x) (new_feature_background-568h@2x)
    fileName = [fileName stringByAppendingString:append];
    
    // 3.获取拓展名(png)
    NSString *extension = [self pathExtension];
    
    // 4.生成新的文件名 (new_feature_background-568h@2x.png)
    return [fileName stringByAppendingPathExtension:extension];
}

#pragma mark - 正则表达式检测并高亮部分文字
-(NSMutableAttributedString *)matchString
{
    // 中括号的规则(微博文题目)
//    NSString *titlePattern = @"【[^】]+】";// 匹配中括号之间的内容（带中括号）
    NSString *titlePattern = @"(?<=【)([^】]+)(?=】)";// 匹配中括号之间的内容（不带中括号）
    NSString *bookPattern = @"(?<=《)([^》]+)(?=》)";// 匹配书名号之间的内容（不带书名号）

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
    NSString *urlPattern = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern,urlPattern];
    NSString *titleOrBookPattern = [NSString stringWithFormat:@"%@|%@", titlePattern, bookPattern];
    
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
//    NSRegularExpression *titleRegex = [[NSRegularExpression alloc] initWithPattern:titlePattern options:0 error:nil];

    NSRegularExpression *titleOrBookRegex = [[NSRegularExpression alloc] initWithPattern:titleOrBookPattern options:0 error:nil];
//    NSRegularExpression *urlRegex = [[NSRegularExpression alloc] initWithPattern:urlPattern options:0 error:nil];

    // 2.测试字符串
    NSRange range = NSMakeRange(0, self.length);
    NSArray *results = [regex matchesInString:self options:0 range:range];
    
//    NSArray *titleResult = [titleRegex matchesInString:self options:0 range:range];
    NSArray *titleOrBookResults = [titleOrBookRegex matchesInString:self options:0 range:range];
//    NSArray *urlResult = [urlRegex matchesInString:self options:0 range:range];
    
    // 3.遍历结果
    NSMutableAttributedString *attStrM = [[NSMutableAttributedString alloc] initWithString:self];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentJustified;
//    paragraphStyle.lineSpacing = kLineSpacing;
//    [paragraphStyle setFirstLineHeadIndent:10];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle mutableParagraphStyleWithLineSpacing:kLineSpacing alignment:NSTextAlignmentJustified];
    [attStrM addAttributes:@{NSFontAttributeName:kTextFont,NSParagraphStyleAttributeName:paragraphStyle} range:range];
//    for (NSTextCheckingResult *result in results) {
//        [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(25,146,245,1)} range:result.range];
//    }
    
//    NSTextCheckingResult *titleTextCheckingResult = titleResult.firstObject;
//    [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(255,86,86,1)} range:titleTextCheckingResult.range];
    
    [titleOrBookResults enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(255,86,86,1)} range:obj.range];
    }];
    
    [results enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(25,146,245,1)} range:obj.range];
    }];
    
//    [urlResult enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [attStrM addAttributes:@{NSForegroundColorAttributeName:LeeColor(25,146,245,1),NSLinkAttributeName:@"https://www.baidu.com"} range:obj.range];
//    }];
        
    return attStrM;
}

@end
