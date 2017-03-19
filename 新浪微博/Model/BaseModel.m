//
//  BaseModel.m
//  新浪微博
//
//  Created by 李中峰 on 16/5/31.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 微博创建时间
        self.createdAt = dict[@"created_at"];
        // 评论／微博的id
        self.ID = [dict[@"id"] longLongValue];
    }
    
    return self;
}

#pragma mark - 重写createdAt的getter方法
-(NSString *)createdAt
{
    // 1.将微博发送时间字符串转为NSDate对象
    // NSDateFormatter就是NSDate的转换类，将NSDate转换为另一种格式或转换回来。NSDate没有自己的输出，需要借助NSDateFormatter以相应格式输出
    // 实例化一个日期转换类对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 开始时，新浪服务器返回的_createdAt为createdAt:Wed Apr 20 17:31:26 +0800 2016，则设置格式应如下
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss ZZZZ yyyy";
    // 区域语言是 en_US，指的是美国英语，以美国英语方式设置日期，真机调试必须写这一句，否则奔溃
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [formatter dateFromString:_createdAt];// date被设置为了：2016-04-20 09:31:26 +0000
    
    // 2.处理date
    // 实例化一个日历类对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得当前时间年份差距
    NSDate *now = [NSDate date];
    // 计算date和当前时间的年份差距
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date toDate:now options:0];
    
    NSInteger yearDiff = [dateComponent year];
    //    NSInteger monthDiff = [dateComponent month];
    //    NSInteger dayDiff = [dateComponent day];
    //    NSInteger hourDiff = [dateComponent hour];
    //    NSInteger minuteDiff = [dateComponent minute];
    
    // 比较微博发送时间的年份是不是今年
    if (yearDiff) {// 若yearDiff非0，则说明不是今年，则展示为xx-x-x xx:xx，如15-3-7 01:05
        formatter.dateFormat = @"yy-M-d HH:mm";// yyyy-MM-dd HH:mm:ss
        return [formatter stringFromDate:date];
    }else{// 是今年
        // 2.将NSDate跟当前时间比较，生成合理的字符串
        // 获得当前时间
        // 获得微博发送时间和当前时间的时间间隔
        NSTimeInterval timeInterval = fabs([date timeIntervalSinceNow]);
        // 根据时间间隔算出合理的字符串
        if (timeInterval <= 60) {// 1分钟内
            return @"刚刚";
        }else if (timeInterval < 3600){// 1小时内
            return [NSString stringWithFormat:@"%.f分钟前",timeInterval/60];
        }else if(timeInterval < 86400){// 1天内
            return [NSString stringWithFormat:@"%.f小时前",timeInterval/3600];
        }else if(timeInterval < 172800){// 2天内
            return @"昨天";
        }else if (timeInterval < 259200){// 3天内
            return @"前天";
        }else{
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:date];
        }
        
        // 也可以用date和当前时间的各日期差距来获取相应的时间字符串
        //        if (monthDiff == 0) {
        //            if (dayDiff == 0) {
        //                if (hourDiff == 0) {
        //                    if (minuteDiff == 0) {
        //                        return @"刚刚";
        //                    }else{
        //                        return [NSString stringWithFormat:@"%d分钟前",(int)minuteDiff];
        //                    }
        //                }else{
        //                    return [NSString stringWithFormat:@"%d小时前",(int)hourDiff];
        //                }
        //            }else if (dayDiff == 1){
        //                return @"昨天";
        //            }else if (dayDiff == 2){
        //                return @"前天";
        //            }else{
        //                formatter.dateFormat = @"MM-dd HH:mm";
        //                return [formatter stringFromDate:date];
        //            }
        //        }else{
        //            formatter.dateFormat = @"MM-dd HH:mm";
        //            return [formatter stringFromDate:date];
        //        }
        
        //        if (monthDiff) {// monthDiff非0，说明不是同一月份
        //            formatter.dateFormat = @"M-d H:m";
        //            return [formatter stringFromDate:date];
        //        }else{// monthDiff为0，说明是同一月份
        //            if (dayDiff == 2) {// 同一月份时，dayDiff == 2，说明是前天
        //                return @"前天";
        //            }else if (dayDiff == 1){// 同一月份时，dayDiff == 1，说明是昨天
        //                return @"昨天";
        //            }else if(dayDiff == 0){// 同一月份时，dayDiff == 0，说明是今天
        //                if (hourDiff) {// 同一天内，判断hourDiff是否非0。非0，则说明是“xx小时之前”，小时差距，可用作“xx小时前”
        //                    return [NSString stringWithFormat:@"%d小时前",(int)hourDiff];
        //                }else{// hourDiff为0，说明是同一小时内
        //                    if (minuteDiff) {// 同一小时内，判断minuteDiff是否为0.非0，则说明是“xx分钟前”，分钟差距，可用作“xx分钟之前”
        //                        return [NSString stringWithFormat:@"%d分钟前",(int)minuteDiff];
        //                    }else{// minuteDiff为0，则说明是在一分钟内，返回“刚刚”
        //                        return @"刚刚";
        //                    }
        //                }
        //            }else{
        //                formatter.dateFormat = @"M-d H:m";
        //                return [formatter stringFromDate:date];
        //            }
        //        }
    }
}

@end
