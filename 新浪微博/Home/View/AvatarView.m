//
//  AvatarView.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/18.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "AvatarView.h"
#import "User.h"
#import "HttpTool.h"

@interface AvatarView ()

@property (nonatomic,strong) UIImageView *avatarImageView;// 头像
@property (nonatomic,strong) UIImageView *vertifyImageView;// 认证图标
@property (nonatomic,copy) NSString *placeholder;// 头像占位图片

@end

@implementation AvatarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 任何UIView内部都会掉用initWithFrame方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.用户头像图片
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        
        // 2.AvatarView右下角的认证图标
        _vertifyImageView = [[UIImageView alloc] init];
        _vertifyImageView.layer.masksToBounds = YES;
        _vertifyImageView.layer.borderWidth = 1.5f;
        _vertifyImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        // 3.添加到AvatarView中
        [self addSubview:_avatarImageView];
        [self addSubview:_vertifyImageView];
    }
    
    return self;
}

#pragma mark - 重写avatarType的setter方法，设置头像和认证图标的frame
-(void)setAvatarType:(AvatarType)avatarType
{
    _avatarType = avatarType;
    
    // 1.判断头像类型，设置对应的头像大小，并采用不同大小的占位头像图片
    CGSize avatarImageViewSize;
    
    switch (avatarType) {
        case kAvatarTypeSmall:// 小头像
            avatarImageViewSize = CGSizeMake(kAvatarSmallWidth, kAvatarSmallHeight);
            _placeholder = @"avatar_default_small";
            break;
        case kAvatarTypeDefault:// 中等头像
            avatarImageViewSize = CGSizeMake(kAvatarDefaultWidth, kAvatarDefaultHeight);
            _placeholder = @"avatar_default";
            break;
        case kAvatarTypeBig:// 大头像
            avatarImageViewSize = CGSizeMake(kAvatarBigWidth, kAvatarBigHeight);
            _placeholder = @"avatar_default_big";
            break;
    }
    
    // 2.设置frame
    // 头像的frame
    _avatarImageView.frame = (CGRect){CGPointZero,avatarImageViewSize};
    _avatarImageView.layer.cornerRadius = avatarImageViewSize.width * 0.5;
    
    // 认证图标的frame
    CGSize vertifyImageViewSize = CGSizeMake(kVertifyImageViewWidth, kVertifyImageViewHeight);
    _vertifyImageView.bounds = (CGRect){CGPointZero,vertifyImageViewSize};
    _vertifyImageView.layer.cornerRadius = vertifyImageViewSize.width * 0.5;
    // 也可以用layer的position和anchorPoint来做
//    _vertifyImageView.layer.position = CGPointMake(avatarImageViewSize.width * 0.85, avatarImageViewSize.height * 0.85);
//    _vertifyImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    // 认证图标放在头像的右下角
    _vertifyImageView.center = CGPointMake(avatarImageViewSize.width * 0.85, avatarImageViewSize.height * 0.85);
    
    // 3.avatarView整体头像的size
    CGFloat avatarViewWidth = avatarImageViewSize.width + vertifyImageViewSize.width * 0.5;
    CGFloat avatarViewHeight = avatarImageViewSize.height + vertifyImageViewSize.height * 0.5;
    CGSize avatarViewSize = CGSizeMake(avatarViewWidth, avatarViewHeight);
    self.bounds = (CGRect){CGPointZero,avatarViewSize};
}

#pragma mark - 重写user的setter方法，设置头像图片并根据认证类型来设置认证图标的图片
-(void)setUser:(User *)user
{
    _user = user;
    
    // 1.设置用户头像
    [HttpTool downLoadImageWithURL:user.avatarHd imageView:_avatarImageView placeholder:[UIImage imageNamed:_placeholder]];
    
    // 2.设置认证图标
    NSString *verifiedTypeImageName = nil;
    
    switch (user.verifiedType) {
        case kVerifiedTypeNone:// 没有经过认证的普通用户
            _vertifyImageView.hidden = YES;
            break;
        case kVerifiedTypeMiddleHighExpert | kVerifiedTypePrimerExpert:// 微博达人(200和220)，五角星
            verifiedTypeImageName = @"avatar_grassroot";
            break;
        case kVerifiedTypePerson:// 微博个人认证，黄V
            verifiedTypeImageName = @"avatar_vip";
            break;
        default:// 机构认证（企业、学校、媒体、官网、应用、团体、待审企业），蓝V
            verifiedTypeImageName = @"avatar_enterprise_vip";
            break;
    }
    
    if (verifiedTypeImageName.length) {
        _vertifyImageView.hidden = NO;
        _vertifyImageView.image = [UIImage imageNamed:verifiedTypeImageName];
    }
}


//#pragma mark - 当外界调用_avatar.frame时就会掉用这个方法
//-(void)setFrame:(CGRect)frame
//{
//    frame.size = self.bounds.size;
//    [super setFrame:frame];
//}

#pragma mark - 外界掉用这个类方法来获得对应类型的头像大小
+(CGSize)avatarViewWithType:(AvatarType)avatarType
{
    CGSize avatarViewSize;
    
    switch (avatarType) {
        case kAvatarTypeSmall:// 小图标
            avatarViewSize = CGSizeMake(kAvatarSmallWidth, kAvatarSmallHeight);
            break;
        case kAvatarTypeDefault:// 中等图标
            avatarViewSize = CGSizeMake(kAvatarDefaultWidth, kAvatarDefaultHeight);
            break;
        case kAvatarTypeBig:// 大图标
            avatarViewSize = CGSizeMake(kAvatarBigWidth, kAvatarBigHeight);
            break;
    }
    
    CGFloat avatarViewWidth = avatarViewSize.width + kVertifyImageViewWidth * 0.5;
    CGFloat avatarViewHeight = avatarViewSize.height + kVertifyImageViewHeight * 0.5;
    
    return CGSizeMake(avatarViewWidth, avatarViewHeight);
}

#pragma mark - 外界掉用这句代码，就可以设置获得对应大小类型的头像
-(void)setUser:(User *)user avatarType:(AvatarType)avatarType
{
    self.avatarType = avatarType;
    self.user = user;
}

@end
