//
//  ShareButton.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/15.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "ShareButton.h"
//#import "UIButton+Helper.h"

@implementation ShareButton

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
        [self setTitle:@"发微博分享给好友" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        
        UIImage *image = [UIImage imageNamed:@"new_feature_button"];
        
        self.bounds = (CGRect){CGPointZero, image.size};
        
        self.adjustsImageWhenHighlighted = NO;
        self.selected = YES;
    }
    
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    return CGRectMake(15, 0, imageSize.width, imageSize.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGFloat titleWidth = contentRect.size.width - imageSize.width;
    return CGRectMake(30, 0, titleWidth, imageSize.height);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
