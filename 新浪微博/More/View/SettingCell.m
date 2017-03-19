//
//  SettingCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/20.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "SettingCell.h"
#import "SettingCellContent.h"
#import "UIImage+Helper.h"

@interface SettingCell ()

@property (nonatomic,strong) UISwitch *switchOnOff;

//@property (nonatomic,copy) NSString *title;

@end

@implementation SettingCell

-(UISwitch *)switchOnOff
{
    if (_switchOnOff == nil) {
        _switchOnOff = [[UISwitch alloc] init];
        [_switchOnOff addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
        _switchOnOff.on = self.settingCellContent.isOn;
    }
    
    return _switchOnOff;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    
    return self;
}

+(instancetype)settingCellWithTableView:(UITableView *)tableView settingCellContent:(SettingCellContent *)settingCellContent
{
    static NSString *cellID = @"settingCell";
    
    SettingCell *settingCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(settingCell == nil) {
        settingCell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        UIImageView *bgView = [[UIImageView alloc] init];
        UIImageView *selectedBgView = [[UIImageView alloc] init];
        
        settingCell.backgroundView = bgView;
        settingCell.selectedBackgroundView = selectedBgView;
    }
    settingCell.settingCellContent = settingCellContent;
    
    return settingCell;
}

-(void)setSettingCellContent:(SettingCellContent *)settingCellContent
{
    _settingCellContent = settingCellContent;
    
    self.imageView.image = [UIImage imageNamed:settingCellContent.icon];
    self.imageView.layer.cornerRadius = self.imageView.image.size.width * 0.5;
    self.imageView.layer.masksToBounds = YES;
    
    if ([settingCellContent.title isEqualToString:@"退出微博"] || [settingCellContent.title isEqualToString:@"退出当前账号"]) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 150, self.contentView.frame.size.height);
        label.center = CGPointMake(kScreenWidth * 0.5, self.contentView.frame.size.height * 0.5);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = LeeColor(255,0,0,1.0);
        label.text = settingCellContent.title;
        [self.contentView addSubview:label];
    }else{
        self.textLabel.text = settingCellContent.title;
    }
    
    if (settingCellContent.settingCellContentType == SettingCellContentTypeDisclosureIndicator) {
        self.accessoryType = SettingCellContentTypeDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if (settingCellContent.settingCellContentType == SettingCellContentTypeSwitch){
        self.accessoryView = self.switchOnOff;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (settingCellContent.settingCellContentType == SettingCellContentTypeLabelAndDisclosureIndicator){
        self.accessoryType = SettingCellContentTypeDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.detailTextLabel.text = settingCellContent.subTitle;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

#pragma mark - 重写indexPath的setter方法
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

#pragma mark - 重写section的setter方法
// 重写indexPath的setter方法和重写section的setter方法就是为了将indexPath和section传进来，从而设置各个cell的背景view
-(void)setSection:(NSArray *)section
{
    _section = section;
    
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    if (section.count == 1) {// section的长度为1，说明该组中只有一个cell，将该cell背景视图设置为圆角矩形
        bgView.image = [UIImage stretchImageWithImageName:@"common_card_background"];
        selectedBgView.image = [UIImage stretchImageWithImageName:@"common_card_background_highlighted"];
    }else if(_indexPath.row == 0){// section的长度不为1，说明该组中有多个cell，将第一个cell设置为上边圆角矩形
        bgView.image = [UIImage stretchImageWithImageName:@"common_card_top_background"];
        selectedBgView.image = [UIImage stretchImageWithImageName:@"common_card_top_background_highlighted"];
    }else if (_indexPath.row == section.count - 1){// section的长度不为1，说明该组中有多个cell，将最后一个cell设置为下边圆角矩形
        bgView.image = [UIImage stretchImageWithImageName:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage stretchImageWithImageName:@"common_card_bottom_background_highlighted"];
    }else{// 来到这里，说明既不是单个cell，也不是第一个cell和最后一个cell，而是中间的cell，将该cell的背景视图设置为矩形
        bgView.image = [UIImage stretchImageWithImageName:@"common_card_middle_background"];
        selectedBgView.image = [UIImage stretchImageWithImageName:@"common_card_middle_background_highlighted"];
    }
}

-(void)switchChanged
{
    // 更改模型的状态
    self.settingCellContent.on = self.switchOnOff.isOn;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setFrame:(CGRect)frame
{
    if ([self.textLabel.text isEqualToString:@"@我的"] && self.imageView.image) {
        CGFloat margin = 15;
        frame.origin.x = margin;
        frame.size.width -= 2 * margin;
        [super setFrame:frame];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
