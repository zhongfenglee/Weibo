//
//  ImageListView.h
//  新浪微博
//
//  Created by 李中峰 on 16/4/19.
//  Copyright © 2016年 李中峰. All rights reserved.
//  配图列表

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

// 所有需要展示的图片的url
@property (nonatomic,strong) NSArray *imageURLs;

+(CGSize)imageListVeiwSizeWithCount:(NSUInteger)count;

@end
