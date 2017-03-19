//
//  StatusDetailCell.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/28.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "RetweetedStatusOptionBar.h"
#import "Status.h"
#import "StatusDetailVC.h"

#import "MainVC.h"

@interface StatusDetailCell ()

@property (nonatomic,strong) StatusDetailCellFrame *statusDetailCellFrame;
@property (nonatomic,strong) RetweetedStatusOptionBar *retweetedStatusOptionBar;

@end

@implementation StatusDetailCell

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
        // 右下角的操作条
        _retweetedStatusOptionBar = [[RetweetedStatusOptionBar alloc] init];
        
        CGFloat optionBarX = self.retweetedView.frame.size.width - _retweetedStatusOptionBar.frame.size.width;
        CGFloat optionBarY = self.retweetedView.frame.size.height - _retweetedStatusOptionBar.frame.size.height;
        
        _retweetedStatusOptionBar.frame = CGRectMake(optionBarX, optionBarY, 0, 0);
        
        [self.retweetedView addSubview:_retweetedStatusOptionBar];
        
        // 监听被转发微博的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)];
        [self.retweetedView addGestureRecognizer:tap];
    }
    
    return self;
}

-(void)setStatusDetailCellFrame:(StatusDetailCellFrame *)statusDetailCellFrame
{
    _statusDetailCellFrame = statusDetailCellFrame;
    
    [super setBaseStatusCellFrame:statusDetailCellFrame];
    
    // 设置子控件的数据
    _retweetedStatusOptionBar.status = statusDetailCellFrame.status.retweetedStatus;
}

+(instancetype)statusDetailCellWithTableView:(UITableView *)tableView statusDetailCellFrame:(StatusDetailCellFrame *)statusDetailCellFrame
{
    static NSString *cellID = @"statusDetailCell";
    
    StatusDetailCell *statusDetailCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (statusDetailCell == nil) {
        statusDetailCell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // 调用baseStatusCellFrame的set方法，开始设置cell上各控件的位置、尺寸和内容
    statusDetailCell.statusDetailCellFrame = statusDetailCellFrame;
    
    return statusDetailCell;
}

-(void)showRetweeted
{
    // 展示被转发的微博
    // 实例化微博正文控制器
    StatusDetailVC *statusDetailVC = [[StatusDetailVC alloc] init];
    
    // 将对应的homeCellFrame.status属性传递给微博正文控制器的status
    statusDetailVC.status = _retweetedStatusOptionBar.status;
    
    // 经试验发现：MainVC中的字控制器还是最初MainVC类中的那几个控制器（HomeVC/MessageVC/ProfileVC/DiscoverVC/MoreVC），看来子控制器使用pushViewController:animated:时是不会讲被推出的控制器添加到MainVC或（MainVC的子控制器）的子控制器中，
//    MainVC *mainVC = (MainVC *)self.window.rootViewController;
//    NSLog(@"childViewControllers:%@",kMainVC.childViewControllers);
//    
//    NSLog(@"childViewControllers[0]:%@",kMainVC.childViewControllers[0]);
//    NSLog(@"childViewControllers[1]:%@",kMainVC.childViewControllers[1]);
//    NSLog(@"childViewControllers[2]:%@",kMainVC.childViewControllers[2]);
//    NSLog(@"childViewControllers[3]:%@",kMainVC.childViewControllers[3]);
//    NSLog(@"childViewControllers[4]:%@",kMainVC.childViewControllers[4]);
    
    // 要想推出控制器，必须有navigationController。经试验发现：这里无非就是获得navigationController，因此，childVC可以使用kMainVC中的任何一个子控制器，再拿到其navigationController即可
    UIViewController *childVC = kMainVC.childViewControllers[0];
    [childVC.navigationController pushViewController:statusDetailVC animated:YES];
}

@end
