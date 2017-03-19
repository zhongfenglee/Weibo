//
//  TableViewCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/14.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "HomeCell.h"
#import "ZFConst.h"
#import "BaseStatusCellFrame.h"
#import "OptionBar.h"
#import "HomeCellFrame.h"

@interface HomeCell()

@property (nonatomic,strong) OptionBar *optionBar;// 每个cell底部的操作条
@property (nonatomic,strong) HomeCellFrame *homeCellFrame;

@end

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写UITableViewCell的-initWithStyle:reuseIdentifier方法
// 需要往HomeCell上放什么控件，在这里做。外界掉用[[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];方法时会掉用这个方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 操作条
        // optionBar的原点y值应等于HomeCell的高度－optionBar的高度
        // 注意：UITableViewController会首先掉用设置每行cell高度的方法(-tableView:heightForRowAtIndexPath:)，然后再掉用创建cell的方法(-tableView:cellForRowAtIndexPath:)，因此，在掉用-initWithStyle:reuseIdentifier:方法时，self.frame.size.height已经有值
        CGFloat optionBarY = self.frame.size.height - kOptionBarHeight;
        _optionBar = [[OptionBar alloc] initWithFrame:CGRectMake(0, optionBarY, 0, 0)];
        [self.contentView addSubview:_optionBar];
    }
    
    return self;
}

//-(void)setBaseStatusCellFrame:(BaseStatusCellFrame *)baseStatusCellFrame
//{
//    [super setBaseStatusCellFrame:baseStatusCellFrame];
//    
//    // 操作条
//    _optionBar.status = baseStatusCellFrame.status;
//}

#pragma mark - 创建homeCell
// homeVC中的创建cell的方法中会掉用该方法
+(instancetype)homeCellWithTableView:(UITableView *)tableView homeCellFrame:(HomeCellFrame *)homeCellFrame
{
    static NSString *cellID = @"homeCell";
    
    HomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (homeCell == nil) {
        homeCell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // 调用homeCell中homeCellFrame的setter方法，开始设置homeCell上各控件的位置、尺寸和内容
    homeCell.homeCellFrame = homeCellFrame;
    
    return homeCell;
}

#pragma mark - 重写homeCellFrame的setter方法
// 上面创建homeCell的
-(void)setHomeCellFrame:(HomeCellFrame *)homeCellFrame
{
    _homeCellFrame = homeCellFrame;
    
    // 通过[super setBaseStatusCellFrame:homeCellFrame];来调用homeCell的父类(BaseStatusCell)中BaseStatusCellFrame的setter方法，来设置homeCell上各控件的位置、尺寸和内容
    [super setBaseStatusCellFrame:homeCellFrame];
    
    // 通过调用OptionBar中的status的setter来设置OptionBar中三个按钮的位置、大小、内容
    _optionBar.status = homeCellFrame.status;
}

@end
