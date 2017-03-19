//
//  FigureView.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/21.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "FigureView.h"
#import "HttpTool.h"

#import "HZPhotoBrowser.h"

#import "ImageListView.h"

@interface FigureView() <HZPhotoBrowserDelegate>

@property (nonatomic,strong) UIImageView *gifImageView;

@property (nonatomic,assign) int index;

@end

@implementation FigureView

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
        // UIImageView调用了initWithImage后就被设置了默认图片，UIImageView也就有了尺寸，尺寸就是该图片尺寸；单独调用init是没有尺寸的，只是被实例化出来了
        _gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:_gifImageView];
        
        self.userInteractionEnabled = YES;
        // 为FigureView添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

-(void)setPicURL:(NSString *)picURL
{
    _picURL = picURL;
    
    _picURL = [_picURL stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    // 下载图片
    [HttpTool downLoadImageWithURL:self.picURL imageView:self placeholder:[UIImage imageNamed:@"timeline_image_loading"]];
    
    // 判断是否是gif
    _gifImageView.hidden = ![picURL.lowercaseString hasSuffix:@"gif"];
}

-(void)setFrame:(CGRect)frame
{
    // 设置_gifImageView的位置
    CGRect gifImageViewFrame = _gifImageView.frame;
    
    gifImageViewFrame.origin.x = frame.size.width - gifImageViewFrame.size.width;
    gifImageViewFrame.origin.y = frame.size.height - gifImageViewFrame.size.height;

    _gifImageView.frame = gifImageViewFrame;
    
    [super setFrame:frame];
}

-(void)magnifyImage
{
    //启动图片浏览器
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    ImageListView *imageListView = (ImageListView *)self.superview;
    
    browser.sourceImagesContainerView = imageListView; // 原图的父控件
    browser.imageCount = (int)imageListView.imageURLs.count; // 图片总数
    browser.currentImageIndex = (int)[imageListView.subviews indexOfObject:self];
    browser.delegate = self;
    
    [browser show];
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
//    FigureView *imageView = (FigureView *)self.subviews[index];
    
    return self.image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    ImageListView *imageListView = (ImageListView *)self.superview;
    
    NSString *thumbnailPicUrlStr = imageListView.imageURLs[index][@"thumbnail_pic"];
    NSString *bmiddlePicUrlStr = [thumbnailPicUrlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    NSString *originalPicUrlStr = [bmiddlePicUrlStr stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
    
    return [NSURL URLWithString:originalPicUrlStr];
}

@end
