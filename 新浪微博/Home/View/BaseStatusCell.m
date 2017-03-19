//
//  BaseStatusCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "BaseStatusCell.h"
#import "AvatarView.h"
#import "ImageListView.h"
#import "UIImage+Helper.h"
#import "ZFConst.h"
#import "Status.h"
#import "BaseStatusCellFrame.h"
#import "User.h"

//#import "TTTAttributedLabel.h"
#import "TextView.h"

@interface BaseStatusCell ()

@property (nonatomic,strong) UIView *topView;// 该控件盛放着用户头像、昵称、会员、时间、来源，用来做该区域的背景色操作

// 原创微博的内容、配图
@property (nonatomic,strong) ImageListView *figureView;// 配图

// 转发微博的子控件
@property (nonatomic,strong) UILabel *retweetedScreenName;// 昵称
//@property (nonatomic,strong) UILabel *retweetedText;// 内容
//@property (nonatomic,strong) UITextView *retweetedText;// 内容

@property (nonatomic,strong) TextView *retweetedTextView;

@property (nonatomic,strong) ImageListView *retweetedFigureView;// 配图

@end

@implementation BaseStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1.添加原创微博子控件
        [self addOriginalWeiboSubviews];
        // 2.添加转发微博子控件
        [self addRetweetedWeiboSubviews];
//        // 3.设置背景
//        [self setBgView];
    }
    
    return self;
}

#pragma mark - 添加原创微博控件
-(void)addOriginalWeiboSubviews
{
//    // 添加原创微博的子控件
//    // 1.头像
//    self.avatar = [[AvatarView alloc] init];
//    
//    // 2.昵称
//    self.screenName = [[UILabel alloc] init];
//    self.screenName.font = kScreenNameFont;
//    self.screenName.backgroundColor = [UIColor clearColor];
//    
//    // 3.皇冠图标
//    self.mbImageView = [[UIImageView alloc] init];
//    
//    // 4.时间
//    self.time = [[UILabel alloc] init];
//    self.time.font = kTimeFont;
//    self.time.textColor = LeeColor(127,127,127,1.0);
//    self.time.backgroundColor = [UIColor clearColor];
    
//    // 5.来源
//    self.source = [[UILabel alloc] init];
//    self.source.font = kSourceFont;
//    self.source.textColor = LeeColor(127,127,127,1.0);
//    self.source.backgroundColor = [UIColor clearColor];
    
    // 7.将上述控件都加入topView中，以做背景色的操作
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = LeeColor(253,253,253,1.0);
    
    // 8.内容
//    self.text = [[UILabel alloc] init];
//    self.text.font = kTextFont;
//    self.text.numberOfLines = 0;
//    self.text.lineBreakMode = NSLineBreakByWordWrapping;
//    self.text.backgroundColor = [UIColor clearColor];
    
    // 9.配图
    self.figureView = [[ImageListView alloc] init];
        
    // 添加到cell中
    // 用户头像、昵称、会员、时间、来源添加到topView中
    [self.topView addSubview:self.avatar];
    [self.topView addSubview:self.screenName];
    [self.topView addSubview:self.mbImageView];
    [self.topView addSubview:self.time];
    [self.topView addSubview:self.source];
    
    // topView、内容、配图添加到contentView中
    [self.contentView addSubview:self.topView];
//    [self.contentView addSubview:self.text];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.figureView];
}

#pragma mark - 添加被转发微博控件
-(void)addRetweetedWeiboSubviews
{
    // 添加转发微博的子控件
    // 1.昵称
    self.retweetedScreenName = [[UILabel alloc] init];
    self.retweetedScreenName.font = kRetweetedScreenNameFont;
    self.retweetedScreenName.textColor = LeeColor(25,146,245,1);
    self.retweetedScreenName.backgroundColor = [UIColor clearColor];
    
    // 2.内容
//    self.retweetedText = [[UILabel alloc] init];
////    self.retweetedText = [[UITextView alloc] init];
////    self.retweetedText.editable = NO;
////    self.retweetedText.dataDetectorTypes = UIDataDetectorTypeAll;
////    self.retweetedText.selectable = YES;
////    self.retweetedText.font = kRetweetedTextFont;
//    self.retweetedText.numberOfLines = 0;
//    self.retweetedText.lineBreakMode = NSLineBreakByWordWrapping;
//    self.retweetedText.backgroundColor = [UIColor clearColor];
    self.retweetedTextView = [[TextView alloc] init];
    
    // 3.配图
    self.retweetedFigureView = [[ImageListView alloc] init];
    
    // 4.将上述控件都加入topView中，以做背景色的操作
    self.retweetedView = [[UIView alloc] init];
    self.retweetedView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        
    // 添加到cell中
    [self.retweetedView addSubview:self.retweetedScreenName];
//    [self.retweetedView addSubview:self.retweetedText];
    [self.retweetedView addSubview:self.retweetedTextView];
    [self.retweetedView addSubview:self.retweetedFigureView];
    [self.contentView addSubview:self.retweetedView];
}

//#pragma mark - 设置cell的默认背景图片和被选中时的背景图片
//-(void)setBgView
//{
//    // 先清空backgroundColor，否则会出现背景图片加载的不好
//    self.backgroundColor = [UIColor clearColor];
//    self.backgroundView = nil;
//    self.selectedBackgroundView = nil;
//    
//    // 1.设置默认背景
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage stretchImageWithImageName:@"common_card_background"]];
//    // 2.长按背景
//    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage stretchImageWithImageName:@"common_card_background_highlighted"]];
//}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableViewBorder;
    frame.origin.y += kTableViewBorder;
    // cell有边距
    frame.size.width -= 2 * kTableViewBorder;
    // cell之间增加间距
    frame.size.height -= kCellMargin;
    
    [super setFrame:frame];
}

#pragma mark - 重写baseStatusCellFrame的set方法，外界掉用homeCell.baseStatusCellFrame = baseStatusCellFrame方法时，会来到这个方法
// 1.设置各控件的frame
// 2.设置各控件的内容
-(void)setBaseStatusCellFrame:(BaseStatusCellFrame *)baseStatusCellFrame
{
    _baseStatusCellFrame = baseStatusCellFrame;
    Status *status = baseStatusCellFrame.status;
    
    // 设置原创微博的各控件的位置、尺寸、内容
    [self setOriginalWeiboSubviewsWithbaseStatusCellFrame:baseStatusCellFrame status:status];
    // 设置转发微博的各控件的位置、尺寸、内容
    [self setRetweetedWeiboSubviewsWithbaseStatusCellFrame:baseStatusCellFrame status:status];
}

#pragma mark 设置原创微博的各控件的位置、尺寸、内容
-(void)setOriginalWeiboSubviewsWithbaseStatusCellFrame:(BaseStatusCellFrame *)baseStatusCellFrame status:(Status *)status
{
    // 原创微博子控件尺寸和内容
    // 1.头像
    self.avatar.frame = baseStatusCellFrame.avatarFrame;
    [self.avatar setUser:status.user avatarType:kAvatarTypeSmall];
    
    // 2.昵称
    User *user = status.user;
    self.screenName.frame = baseStatusCellFrame.screenNameFrame;
    self.screenName.text = user.screenName;
    
    // 3.会员图标
    if (user.mbType == kMBTypeNone) {// 若不是会员，将__mbImageView隐藏
        self.screenName.textColor = LeeColor(93,93,93,1.0);
        self.mbImageView.hidden = YES;
    }else{// 是会员，变换昵称颜色，显示_mbImageView
        self.screenName.textColor = LeeColor(243,101,18,1.0);
        self.mbImageView.hidden = NO;
        self.mbImageView.frame = baseStatusCellFrame.mbRankFrame;
        self.mbImageView.image = [UIImage imageNamed:[@"common_icon_membership_level" stringByAppendingFormat:@"%d",user.mbRank]];
    }
    
    // 4.时间
    self.time.frame = baseStatusCellFrame.timeFrame;
    self.time.text = status.createdAt;
    [self.time sizeToFit];
//    CGFloat timeFrameX = baseStatusCellFrame.screenNameFrame.origin.x;
//    CGFloat timeFrameY = CGRectGetMaxY(baseStatusCellFrame.screenNameFrame) + kCellBorderMargin * 0.1;
//    CGSize timeSize = [_time.text sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
//    _time.frame = (CGRect){{timeFrameX, timeFrameY}, timeSize};
    
    // 5.来源
    self.source.frame = baseStatusCellFrame.sourceFrame;
    self.source.text = status.source;
//    CGFloat sourceFrameX = CGRectGetMaxX(_time.frame) + kCellBorderMargin;
//    CGFloat sourceFrameY = timeFrameY;
//    CGSize sourceSize = [_source.text sizeWithAttributes:@{NSFontAttributeName:kSourceFont}];
//    _source.frame = (CGRect){{sourceFrameX, sourceFrameY}, sourceSize};
    
    // 6.topView
    self.topView.frame = baseStatusCellFrame.topViewFrame;
    
    // 7.内容
//    self.text.frame = baseStatusCellFrame.textFrame;
//        
////    self.text.contentSize = baseStatusCellFrame.textFrame.size;
////    self.text.text = status.text;
////    self.text.attributedText = status.attStrM;
//    self.text.attributedText = status.attStrM;
////    [self.text sizeToFit];
    
//    self.textView.textContainer.size = baseStatusCellFrame.textFrame.size;
//    CGRect textViewFrame = self.textView.frame;
//    textViewFrame.origin = baseStatusCellFrame.textFrame.origin;
//    self.textView.frame = textViewFrame;
//    
//    CGSize textViewContentSize = baseStatusCellFrame.textFrame.size;
//    self.textView.contentSize = textViewContentSize;

    
    self.textView.frame = baseStatusCellFrame.textFrame;
    self.textView.attributedText = status.attStrM;
//    self.textView.frame = (CGRect){baseStatusCellFrame.textFrame.origin, self.textView.contentSize};
//    [self.textView sizeToFit];
//    [self.textView layoutIfNeeded];
    
    // 8.配图
    if (status.thumbnailPicUrls.count) {// 有配图，显示_figureView
        self.figureView.hidden = NO;
        self.figureView.frame = baseStatusCellFrame.FigureViewFrame;
//        CGFloat y = CGRectGetMaxY(self.textView.frame);
//        self.figureView.frame = (CGRect){baseStatusCellFrame.FigureViewFrame.origin.x,y,baseStatusCellFrame.FigureViewFrame.size};
        self.figureView.imageURLs = status.thumbnailPicUrls;
    }else{// 无配图，隐藏_figureView
        self.figureView.hidden = YES;
    }
}

#pragma mark 设置转发微博的各控件的位置、尺寸、内容
-(void)setRetweetedWeiboSubviewsWithbaseStatusCellFrame:(BaseStatusCellFrame *)baseStatusCellFrame status:(Status *)status
{
    // 添加转发微博的子控件
    if (status.retweetedStatus) {// 有转发微博，显示_retweetedView
        // 1.昵称
        _retweetedScreenName.frame = baseStatusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = status.retweetedStatus.user.screenName;
        
        // 2.内容
//        _retweetedText.frame = baseStatusCellFrame.retweetedTextFrame;
////        _retweetedText.text = status.retweetedStatus.text;
//        _retweetedText.attributedText = status.retweetedStatus.attStrM;
//        self.retweetedTextView.textContainer.size = baseStatusCellFrame.textFrame.size;
        _retweetedTextView.frame = baseStatusCellFrame.retweetedTextFrame;
        _retweetedTextView.attributedText = status.retweetedStatus.attStrM;
//        _retweetedTextView.frame = (CGRect){baseStatusCellFrame.textFrame.origin, _retweetedTextView.contentSize};
//        [_retweetedTextView sizeToFit];
//        [_retweetedTextView layoutIfNeeded];
        
        // 3.配图
        if (status.retweetedStatus.thumbnailPicUrls.count) {
            _retweetedFigureView.hidden = NO;
            _retweetedFigureView.frame = baseStatusCellFrame.retweetedFigureViewFrame;
            _retweetedFigureView.imageURLs = status.retweetedStatus.thumbnailPicUrls;
        }else{
            _retweetedFigureView.hidden = YES;
        }
        
        // 4._retweetedView
        _retweetedView.hidden = NO;
        _retweetedView.frame = baseStatusCellFrame.retweetedViewFrame;
    }else{// 无转发微博，隐藏_retweetedView
        _retweetedView.hidden = YES;
    }
}

@end
