//
//  HomeVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/1/17.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "HomeVC.h"
#import "UIBarButtonItem+Helper.h"
#import "Status.h"
#import "HomeCell.h"
#import "StatusTool.h"
#import "MBProgressHUD.h"
#import "HomeCellFrame.h"
#import "MJRefresh.h"
#import "UIButton+Helper.h"
#import "StatusDetailVC.h"
#import "AudioTool.h"

@interface HomeVC () <UITextViewDelegate>

// 盛放homeCellFrame的可变数组
@property (nonatomic,strong) NSMutableArray *homeCellFrameArray;

// 刷新控件
@property (nonatomic,strong) MJRefreshAutoNormalFooter *refreshStateFooter;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、实例化数组
    _homeCellFrameArray = [NSMutableArray array];
    
    // 2、设置界面属性
    [self setUI];
}

//#pragma mark - 重写这个方法：去掉父类默认的操作－一启动就显示滚动条。应该让控制器view被拖动时才显示滚动条
//-(void)viewDidAppear:(BOOL)animated{}

#pragma mark - 设置界面属性
-(void)setUI
{
    // 导航栏标题
    self.navigationItem.title = @"首页";
    
    // 导航栏上左右边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImage:@"navigationbar_compose" target:self action:@selector(sendWeibo)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImage:@"navigationbar_pop" target:self action:@selector(pop)];
    
    // 解决tableView最后一行cell被浮层控件遮盖住：为collectionView的内容视图增加额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    // 删除tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // tableView背景色
    self.tableView.backgroundColor = kGlobalColor;
        
    // 添加刷新控件
    [self addRefreshViews];
}

#pragma mark - 添加刷新控件
-(void)addRefreshViews
{
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    // 下拉刷新（可使用实例化方法也可使用block）
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadStatusData)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewStatusData];
    }];
    // 程序一启动就掉用刷新方法，获得数据
    [self.tableView.mj_header beginRefreshing];
    
//    // 上拉加载更多(同时使用self.tableView.mj_header和self.tableView.mj_footer，首次进入主页刷新时，同时显示self.tableView.mj_header和self.tableView.mj_footer的刷新提示文字，bug???)
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        [weakSelf loadOldStatusData];
//    }];
    
    // 解决上述不好的现象：
    _refreshStateFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldStatusData)];
//    [footer setTitle:@"更多" forState:MJRefreshStateIdle];
}

#pragma mark - 下拉加载新微博数据
-(void)loadNewStatusData
{
    // 获得第一条微博的ID（发布时间最晚的微博是放在数组的最前面，数组的长度已有参数@"count":@2定死，传多少参数，就固定了_homeCellFrameArray数组的长度）
    int64_t firstStatusId = _homeCellFrameArray.count? [[[_homeCellFrameArray firstObject] status] ID] : 0;
    
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    // 若指定firstStatusId参数，则返回ID比since_id大的微博（即比since_id时间晚的微博，即新微博），默认为0。实验发现，每次下拉刷新，即使没有新微博，都回返回对应及小于firstStatusId的微博，造成数据重复加载，应当是新郎服务器返回数据有bug
    [StatusTool statusesWithSinceId:firstStatusId maxId:0 statusSuccess:^(NSArray *array) {
        
        // 这个数组放着最新的微博
        NSMutableArray *newHomeCellFrame = [NSMutableArray array];
        
        // 1.拿到最新的数据的同时计算它的frame
        for (Status *status in array) {
            
            // 解决上述返回数据重复的bug：当返回的微博数据的id小于或等于firstStatusId，利用continue跳出当前循环体，即continue下面的代码不被执行，直接进入下一次循环，再拿出数组中的微博数据，再比较其id和firstStatusId的大小。。。
            if (status.ID <= firstStatusId) {
                continue ;
            }
            
            // 能来到这里，说明取出的微博是大于firstStatusId的，即其发布时间比firstStatusId晚，是新微博数据
            // 实例化一个HomeCellFrame
            HomeCellFrame *homeCellFrame = [[HomeCellFrame alloc] init];
            // 点语法利用HomeCellFrame中的status的setter方法，该setter方法中利用[super setStatus:status];来调用父类StatusDetailCellFrame中的status的setter方法设置其所有的frame属性(这些属性分别对应着StatusDetailCell上各控件的位置、尺寸)，然后子类HomeCellFrame就可以拿到具有具体数值的这些frame属性了
            homeCellFrame.status = status;

            // 将最终该次下拉刷新得到的对应新微博数据的HomeCellFrame加入到一个数组中，以插入到homeCellFrameArray这个整体数组中
            [newHomeCellFrame addObject:homeCellFrame];
        }
        
//        // 将之前的数据数组拼接到最新数据数组后面
//        [newHomeCellFrame addObjectsFromArray:weakSelf.homeCellFrameArray];
//        
//        // 再赋给之前的数据数组
//        weakSelf.homeCellFrameArray = newHomeCellFrame;
        // 不移掉数组中的所有对象，则会出现数据重复现象；但移除掉所有数据，就造成重新下载原有的数据，性能不好
//        [_homeCellFrameArray removeAllObjects];

        [weakSelf.homeCellFrameArray insertObjects:newHomeCellFrame atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,newHomeCellFrame.count)]];
        
        // 2.刷新数据：重新访问数据源，重新给数据源和代理发送所有需要的消息（重新调用数据源和代理 所有需要的方法）
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        // 展示新微博数目
        [weakSelf showNewStatusCount:newHomeCellFrame.count];
        
        // 程序一启动下拉刷新后，将上拉刷新赋给tableView.mj_footer，为提高性能，先检测tableView.mj_footer是不是下拉刷新，再判断是否做赋值
        if (weakSelf.tableView.mj_footer != _refreshStateFooter) {
            weakSelf.tableView.mj_footer = _refreshStateFooter;
        }
    } statusFailure:^(NSError *error) {
        [weakSelf showHUD];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 展现HUD
-(void)showHUD
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"获取微博数据失败，请稍后再试";
    // Move to center.
    hud.offset = CGPointMake(0.f, 0.5f);
    [hud hideAnimated:YES afterDelay:3.f];
}

#pragma mark - 上拉加载旧(更多)数据
-(void)loadOldStatusData
{
    // 获得最后一条微博的ID(_homeCellFrameArray中最旧的微博是发布时间最早的微博，取出其ID，再减1，就可得到发布时间更早的旧微博。下拉刷新加载多少条旧微博，是由参数@“count”:@2来决定的)
    int64_t lastStatusId = [[[_homeCellFrameArray lastObject] status] ID];
//    lastStatusId --;
    
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    [StatusTool statusesWithSinceId:0 maxId:--lastStatusId statusSuccess:^(NSArray *array) {
        
        // 这个数组用来盛放旧微博
        NSMutableArray *newHomeCellFrame = [NSMutableArray array];
        
        // 1.拿到旧数据的同时计算它的frame
        for (Status *status in array) {
            HomeCellFrame *homeCellFrame = [[HomeCellFrame alloc] init];
            homeCellFrame.status = status;
            
            // 添加到newHomeCellFrame中
            [newHomeCellFrame addObject:homeCellFrame];
        }
        
        // 将下拉刷新得到的旧数组拼接到homeCellFrameArray数组后面
        [weakSelf.homeCellFrameArray addObjectsFromArray:newHomeCellFrame];
        
        // 刷新数据：重新访问数据源，重新给数据源和代理发送所有需要的消息（重新调用数据源和代理的所有需要的方法）
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } statusFailure:^(NSError *error) {
        [weakSelf showHUD];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 加载用户微博数据
//-(void)loadStatusData
//{
//    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
//    [StatusTool statusesWithSinceId:0 maxId:0 statusSuccess:^(NSArray *array) {
//        // 1.拿到最新的数据的同时计算它的frame
//        for (Status *status in array) {
//            HomeCellFrame *homeCellFrame = [[HomeCellFrame alloc] init];
//            homeCellFrame.status = status;
//            
//            [weakSelf.homeCellFrameArray addObject:homeCellFrame];
//        }
//        // 2.刷新数据：重新访问数据源，重新给数据源和代理发送所有需要的消息（重新调用数据源所有需要的方法）
//        [weakSelf.tableView reloadData];
//    } statusFailure:^(NSError *error) {
//        [weakSelf showHUD];
//    }];
//}

#pragma mark - 展现下拉刷新得到的新微博数据
-(void)showNewStatusCount:(NSUInteger)count
{
    // 有背景图片、文字，用UIButton来做
    UIButton *btn = [UIButton buttonWithImage:nil selectedImageNameAppend:nil highlightedImageNameAppend:nil backgroundImageName:@"timeline_new_status_background" highlightedBgImageNameAppend:nil selectedBgImageNameAppend:nil title:nil target:nil action:nil];
    btn.enabled = NO;// 按钮不可被点击
    
    // button的位置、尺寸
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    CGFloat btnWidth = self.view.frame.size.width;
    CGFloat btnHeight = 45;
    CGFloat btnX = 0;
    CGFloat btnY = navigationBarHeight + 17;
    
    btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    
    // 利用传进来的count设置button的文字
//    NSString *title = count? [NSString stringWithFormat:@"%lu条新微博",(unsigned long)count]:@"没有新微博";
//    [btn setTitle:title forState:UIControlStateNormal];
    
    NSString *title = nil;
    if (count) {
        title = [NSString stringWithFormat:@"%lu条新微博",(unsigned long)count];
        [AudioTool playSound:@"newblogtoast.wav"];
    }else{
        title = @"没有新微博";
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
//    [self.view addSubview:btn];
    [kKeyWindow addSubview:btn];
//    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 逐渐消失
    [UIView animateWithDuration:2.5 animations:^{
        btn.alpha = 0;
    } completion:^(BOOL finished) {
        [btn removeFromSuperview];
    }];
    
    // 上下移动
//    [UIView animateWithDuration:2 animations:^{
//        btn.transform = CGAffineTransformMakeTranslation(0, btnHeight);
//        
//        [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
//            btn.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [btn removeFromSuperview];
//        }];
//    }];
}

-(void)sendWeibo
{
    NSLog(@"发微博");
}

-(void)pop
{
    NSLog(@"pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _homeCellFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellFrame *homeCellFrame = _homeCellFrameArray[indexPath.row];
    return [HomeCell homeCellWithTableView:tableView homeCellFrame:homeCellFrame];
}

#pragma mark - Table view delegate method
#pragma mark - 自适应调节cell高度
// 程序一启动就一次性算出所有cell的高度，比如有100条数据，则有100个cell，就一次性调用100次
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HomeCellFrame *homeCellFrame = self.homeCellFrameArray[indexPath.row];
    return [_homeCellFrameArray[indexPath.row] cellHeight];
}


#pragma mark - 点击cell跳转到微博正文控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 实例化微博正文控制器
    StatusDetailVC *statusDetailVC = [[StatusDetailVC alloc] init];
    
    // 取出对应的homeCellFrame
    HomeCellFrame *homeCellFrame = _homeCellFrameArray[indexPath.row];
    
    // 将对应的homeCellFrame.status属性传递给微博正文控制器的status
    statusDetailVC.status = homeCellFrame.status;
    
    // 推出微博正文控制器
    [self.navigationController pushViewController:statusDetailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
