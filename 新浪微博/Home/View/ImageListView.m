//
//  ImageListView.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/19.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "ImageListView.h"
#import "ZFConst.h"
#import "FigureView.h"

// 将点击ImageListView中的小图展示对应大图的功能做到了FigureView中（我觉得这样更好，ImageListView就是用来展示一个或多个的FigureView的，而FigureView是用来展示单张图片的，用户点击单张图片展示对应大图，什么模块对应什么功能，最好是放在FigureView中，清晰可读，所以注释了部分代码，重新写在了FigureView中）
//#import "HZPhotoBrowser.h"

#define kImageCount 9

@interface ImageListView () //<HZPhotoBrowserDelegate>

@property (nonatomic,assign) NSString *originalPicUrlStr;

@end

@implementation ImageListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 先把有可能展示的控件都加进去
        for (int i = 0; i < kImageCount; i ++) {
            FigureView *imageView = [[FigureView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;// 原图填充
            imageView.clipsToBounds = YES;// 超出imageView边界的剪掉
            
//            imageView.userInteractionEnabled = YES;
//            // 为FigureView添加单击手势
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
//            [imageView addGestureRecognizer:tapGesture];
//            
//            imageView.tag = i;
            
            [self addSubview:imageView];
        }
    }
    
    return self;
}

#pragma mark - 重写imageURLs的setter方法，外界调用点语法来设置各个imageView展示的图片
-(void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    
    // 配图链接个数
    NSUInteger imageUrlsCount = imageURLs.count;
    
    // 有多少配图链接个数，就取出多少个imageView
    for (int i = 0; i < kImageCount; i ++) {
        // 取出对应的子控件（UIImageView）
        FigureView *imageView = self.subviews[i];
        
        if (i >= imageUrlsCount) {// 多出的imageView隐藏
            imageView.hidden = YES;
            continue;// continue的作用：跳出continue下面的语句，i＋1，执行下一次循环
        }
        // 显示
        imageView.hidden = NO;
        
        // 设置各个imageView的图片(首页展示图片就用中等尺寸的图片)
        imageView.picURL = imageURLs[i][@"thumbnail_pic"];// 去FigureView中调用-setPicURL:方法
        
        // 设置各个imageView的frame
        if (imageUrlsCount == 1) {// 1张
            imageView.frame = CGRectMake(0, 0, kOnlyOneImageWidth, kOnlyOneImageHeight);
            continue;
        }
                
        // 多张
        // 行数（2张时、3张时，1行；4张时、5张时、6张时，2行；7张时、8张时、9张时，3行）
        NSUInteger rows = (imageUrlsCount == 4 || imageUrlsCount == 2)? 2 : 3;
        // 第几行（imageView索引 / 3）
        NSUInteger row = i / rows;
        // 第几列（imageView索引 % 3）
        NSUInteger column = i % rows;
        
        CGFloat multiImageWidth = (imageUrlsCount == 4 || imageUrlsCount == 2)? kTwoImageWidth: kMultiImageWidth;
        CGFloat multiImageHeight = (imageUrlsCount == 4 || imageUrlsCount == 2)? kTwoImageHeight: kMultiImageHeight;
        
        // 每张图片的位置(x:(W+HM)*列号；y:(H+HM)*行号）
        CGFloat imageViewX = (multiImageWidth + kImageMargin) * column;
        CGFloat imageViewY = (multiImageHeight + kImageMargin) * row;
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, multiImageWidth, multiImageHeight);
    }
}

#pragma mark - 外界调用这个类方法，传进来图片个数，就可以获得imageListVeiw的大小
+(CGSize)imageListVeiwSizeWithCount:(NSUInteger)count
{
    // 只有1张图片
    if (count == 1) {
        return CGSizeMake(kOnlyOneImageWidth, kOnlyOneImageHeight);
    }
    
    // 至少2张图片
    // 每行展示几列(如果有4张图片，则每行展示2列；如果图片个数>4，则每行展示3列)
    NSUInteger columnPerRow = (count == 4 || count == 2) ? 2 : 3;
    // 总列数（2张，2列；3张、5张、6张、7张、8张、9张、3列；列；4张，2列；）
    NSUInteger columns = (count >= 3)? 3: 2;
    // 总行数（高度取决于总行数）
    NSUInteger rows = (count + columnPerRow - 1) / columnPerRow;
    
    CGFloat multiImageWidth = (count == 4 || count == 2)? kTwoImageWidth: kMultiImageWidth;
    CGFloat multiImageHeight = (count == 4 || count == 2)? kTwoImageHeight: kMultiImageHeight;
    
    // 2张及2张以上图片时，每张图片的宽度：kMultiImageWidth = (kScreenWidth - 2 * kCellBorderMargin - 2 * kImageMargin) / 3.0
//    CGFloat multiImageWidth = (kScreenWidth - 2 * kCellBorderMargin - 2 * kImageMargin) / columnPerRow;
    CGFloat imageListViewWidth = columns * multiImageWidth + (columns - 1) * kImageMargin;
    CGFloat imageListViewHeight = rows * multiImageHeight + (rows - 1) * kImageMargin;
    
    return CGSizeMake(imageListViewWidth, imageListViewHeight);
}

//-(void)magnifyImage:(UITapGestureRecognizer*)tap
//{
//    //启动图片浏览器
//    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
//    
//    browser.sourceImagesContainerView = self; // 原图的父控件
//    browser.imageCount = self.imageURLs.count; // 图片总数
//    browser.currentImageIndex = (int)tap.view.tag;
//    browser.delegate = self;
//    
//    [browser show];
//}
//
//#pragma mark - photobrowser代理方法
//// 返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    FigureView *imageView = (FigureView *)self.subviews[index];
//    
//    return imageView.image;
//}
//
//
//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *bmiddlePicUrlStr = [_imageURLs[index][@"thumbnail_pic"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    NSString *originalPicUrlStr = [bmiddlePicUrlStr stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
//    return [NSURL URLWithString:originalPicUrlStr];
//}

@end
