//
//  DetailHeader.h
//  新浪微博
//
//  Created by 李中峰 on 16/5/12.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;

typedef enum{
    kDetailHeaderRepostBtn,
    kDetailHeaderCommentBtn,
    kDetailHeaderLikeBtn
} DetailHeaderBtnType;

typedef void (^BtnClickedBlock)(DetailHeaderBtnType detailHeaderBtnType);
//typedef void (^BtnClickedBlock)(NSUInteger btnClickedIndex);
//typedef void (^BtnClickedBlock)(NSUInteger index);

@interface DetailHeader : UIView

@property (nonatomic,strong) Status *status;

@property(nonatomic,assign) DetailHeaderBtnType detailHeaderBtnType;

@property (nonatomic,strong) BtnClickedBlock btnClickedBlock;

@end
