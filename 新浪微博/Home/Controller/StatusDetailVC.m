//
//  StatusDetailVC.m
//  新浪微博
//
//  Created by 李中峰 on 16/4/27.
//  Copyright © 2016年 李中峰. All rights reserved.
//

#import "StatusDetailVC.h"
#import "DetailHeader.h"
#import "ZFConst.h"
#import "Status.h"
#import "StatusTool.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "StatusRepostCell.h"
#import "StatusCommentCell.h"
#import "StatusRepostCellFrame.h"
#import "StatusCommentCellFrame.h"
#import "Comment.h"
#import "Repost.h"
#import "MJRefresh.h"

@interface StatusDetailVC ()

@property (nonatomic,strong) StatusDetailCellFrame *statusDetailCellFrame;

@property (nonatomic,strong) NSMutableArray *statusRepostCellFrameM;// 所有转发cell frame
@property (nonatomic,strong) NSMutableArray *statusCommentCellFrameM;// 所有评论cell frame
@property (nonatomic,strong) NSMutableArray *statusLikeCellFrameM;// 所有评论cell frame

@property (nonatomic,strong) DetailHeader *header;

@property (nonatomic,assign) Boolean commentLastPage;// 评论数据是否为最后一页
@property (nonatomic,assign) Boolean repostLastPage;// 转发数据是否为最后一页
@property (nonatomic,assign) Boolean likeLastPage;// 赞数据是否为最后一页

@property (nonatomic,assign) NSUInteger btnClickedIndex;

@end

@implementation StatusDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"微博正文";
    
    // 接收来自HomeVC中homeCellFrame传递过来的status，_statusDetailCellFrame调用-setStatus:方法，-setStatus:再调用[super setStatus:status]方法来设置cell各控件的尺寸、转发微博的高度、cell的高度
    self.statusDetailCellFrame = [[StatusDetailCellFrame alloc] init];
    
    self.statusRepostCellFrameM = [NSMutableArray array];
    self.statusCommentCellFrameM = [NSMutableArray array];
    self.statusLikeCellFrameM = [NSMutableArray array];
    
    self.statusDetailCellFrame.status = _status;
    
    // 获取评论数据
    [self getNewComments];
    [self.tableView reloadData];
    
    self.header = [[DetailHeader alloc] init];
    self.header.detailHeaderBtnType = kDetailHeaderCommentBtn;
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    self.header.btnClickedBlock = ^(DetailHeaderBtnType detailHeaderBtnType){
        weakSelf.header.detailHeaderBtnType = detailHeaderBtnType;
        
        // 先刷新表格（马上显示对应的旧数据）
        [weakSelf.tableView reloadData];
        
        if (detailHeaderBtnType == kDetailHeaderRepostBtn) {// 转发按钮
            [weakSelf getNewReposts];
        }else if (detailHeaderBtnType == kDetailHeaderCommentBtn){// 评论按钮
            [weakSelf getNewComments];
        }else if (detailHeaderBtnType == kDetailHeaderLikeBtn){// 赞按钮
            [weakSelf getNewLikes];
        }
    };
    
    // 添加刷新控件
    [self addRefreshViews];
}

#pragma mark - 添加刷新控件
-(void)addRefreshViews
{
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
            [weakSelf getOldReposts];// 上拉加载更多的转发
        }else if(self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
            [weakSelf getOldComments];// 上拉加载更多的评论
        }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
            [weakSelf getOldLikes];// 上拉加载更多的赞
        }
    }];
    
    self.tableView.mj_footer.hidden = YES;// 首次进入页面时应该隐藏上拉刷新控件

    // 下拉刷新控件（用来刷新微博的转发、评论和赞数据）
//    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [weakSelf getNewStatus];
//    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewStatus)];
}

#pragma mark - 获得当前需要使用的数组
-(NSMutableArray *)currentFrames
{
    NSMutableArray *frames;
    
    if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
        frames = self.statusRepostCellFrameM;
    }else if (self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
        frames = self.statusCommentCellFrameM;
    }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
        frames = self.statusLikeCellFrameM;
    }
    
    return frames;
}

#pragma mark - 解析模型数据为frame数据(获得新数据)
-(NSMutableArray *)getNewDataFramesWithArray:(NSArray *)array firstId:(int64_t)firstId frame:(Class)frame
{
    NSMutableArray *newFrameM = [NSMutableArray array];
    
    for (BaseStatus *model in array) {
        if (model.ID <= firstId) {
            continue ;
        }
        
        BaseStatusCommentRepostLikeCellFrame *frame1 = [[frame alloc] init];
        frame1.baseStatus = model;
        [newFrameM addObject:frame1];
    }
    
    return newFrameM;
}

#pragma mark - 解析模型数据为frame数据(获得旧数据)
-(NSMutableArray *)getOldDataFramesWithArray:(NSArray *)array frame:(Class)frame
{
    NSMutableArray *oldFrameM = [NSMutableArray array];
    
    for (BaseStatus *model in array) {
        BaseStatusCommentRepostLikeCellFrame *frame2 = [[frame alloc] init];
        frame2.baseStatus = model;
        [oldFrameM addObject:frame2];
        }

    return oldFrameM;
}

#pragma mark - 加载单条微博的最新数据
-(void)getNewStatus
{
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    [StatusTool singleStatusWithStatusId:self.status.ID singleStatusSuccess:^(Status *status) {
        // 将微博数据更新为最新的微博
        weakSelf.status = status;
        weakSelf.statusDetailCellFrame.status = status;// 这一步是为了将被转发微博的数据更新为最新状态
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } singleStatusFailure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 获得新评论数据
-(void)getNewComments
{
    StatusCommentCellFrame *fistCommentCellFrame = [self.statusCommentCellFrameM firstObject];
    Comment *firstComment = fistCommentCellFrame.comment;
    
    int64_t firstCommentId = self.statusCommentCellFrameM.count? firstComment.ID : 0;

    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    [StatusTool statusCommentsWithStatusId:weakSelf.status.ID sinceId:firstCommentId maxId:0 commentSuccess:^(NSArray *array, int commentTotalNumber, int64_t nextCursor) {
        
        NSMutableArray *newCommentCellFrame = [NSMutableArray array];

        for (Comment *comment in array) {
            if (comment.ID <= firstCommentId) {
                continue ;
            }
            
            StatusCommentCellFrame *statusCommentCellFrame = [[StatusCommentCellFrame alloc] init];
            statusCommentCellFrame.comment = comment;
            [newCommentCellFrame addObject:statusCommentCellFrame];
        }

//        NSMutableArray *newCommentCellFrame = [weakSelf getNewDataFramesWithArray:array firstId:firstCommentId frame:[StatusCommentCellFrame class]];// 重构后有重复数据，原因？？？
        
        // 更新微博
        weakSelf.status.commentsCount = commentTotalNumber;
        
        [weakSelf.statusCommentCellFrameM insertObjects:newCommentCellFrame atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,newCommentCellFrame.count)]];
        
        weakSelf.commentLastPage = nextCursor == 0;
        
        [weakSelf.tableView reloadData];
    } commentFailure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 获得旧评论数据
-(void)getOldComments
{
    StatusCommentCellFrame *lastCommentCellFrame = [self.statusCommentCellFrameM lastObject];
    Comment *lastComment = lastCommentCellFrame.comment;
    
    int64_t lastCommentId = lastComment.ID;
    
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    [StatusTool statusCommentsWithStatusId:weakSelf.status.ID sinceId:0 maxId:--lastCommentId commentSuccess:^(NSArray *array, int commentTotalNumber, int64_t nextCursor) {
        
        NSMutableArray *oldCommentCellFrame = [NSMutableArray array];
        
        for (Comment *comment in array) {
            StatusCommentCellFrame *statusCommentCellFrame = [[StatusCommentCellFrame alloc] init];
            statusCommentCellFrame.comment = comment;
            [oldCommentCellFrame addObject:statusCommentCellFrame];
        }
        
//        NSMutableArray *oldCommentCellFrame = [weakSelf getOldDataFramesWithArray:array frame:[StatusCommentCellFrame class]];
        
        weakSelf.status.commentsCount = commentTotalNumber;
        
        [weakSelf.statusCommentCellFrameM addObjectsFromArray:oldCommentCellFrame];
        
        weakSelf.commentLastPage = nextCursor == 0;
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_footer endRefreshing];
    } commentFailure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 获得新转发数据
-(void)getNewReposts
{
    // 获取转发数据
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    StatusRepostCellFrame *firstStatusRepostCellFrame = [self.statusRepostCellFrameM firstObject];
    Repost *firstRepost = firstStatusRepostCellFrame.repost;
    
    int64_t firstRepostId = self.statusRepostCellFrameM.count? firstRepost.ID : 0;
    
    [StatusTool statusRepostsWithStatusId:weakSelf.status.ID sinceId:firstRepostId maxId:0 repostSuccess:^(NSArray *array, int repostTotalNumber, int64_t nextCursor) {
        
        NSMutableArray *newRepostCellFrame = [NSMutableArray array];
        
        for (Repost *repost in array) {
            if (repost.ID <= firstRepostId) {
                continue ;
            }
        
            StatusRepostCellFrame *statusRepostCellFrame = [[StatusRepostCellFrame alloc] init];
            statusRepostCellFrame.repost = repost;
            [newRepostCellFrame addObject:statusRepostCellFrame];
        }
        
//        NSMutableArray *newRepostCellFrame = [weakSelf getNewDataFramesWithArray:array firstId:firstRepostId frame:[StatusRepostCellFrame class]];
        
        // 更新微博
        weakSelf.status.repostsCount = repostTotalNumber;
        
        [weakSelf.statusRepostCellFrameM insertObjects:newRepostCellFrame atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,newRepostCellFrame.count)]];
        
        weakSelf.repostLastPage = nextCursor == 0;
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_footer endRefreshing];
    } repostFailure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 获得旧转发数据
-(void)getOldReposts
{
    StatusRepostCellFrame *lastRepostCellFrame = [self.statusRepostCellFrameM lastObject];
    Repost *lastRepost = lastRepostCellFrame.repost;
    
    int64_t lastRepostId = lastRepost.ID;
    
    __block __typeof(self)weakSelf = self;
//    kWeakSelf;
    [StatusTool statusRepostsWithStatusId:weakSelf.status.ID sinceId:0 maxId:--lastRepostId repostSuccess:^(NSArray *array, int repostTotalNumber, int64_t nextCursor) {
        
        NSMutableArray *oldRepostCellFrame = [NSMutableArray array];
        
        for (Repost *repost in array) {
            StatusRepostCellFrame *statusRepostCellFrame = [[StatusRepostCellFrame alloc] init];
            statusRepostCellFrame.repost = repost;
            [oldRepostCellFrame addObject:statusRepostCellFrame];
        }
        
//        NSMutableArray *oldRepostCellFrame = [weakSelf getOldDataFramesWithArray:array frame:[StatusRepostCellFrame class]];
        
        weakSelf.status.repostsCount = repostTotalNumber;
        
        [weakSelf.statusRepostCellFrameM addObjectsFromArray:oldRepostCellFrame];
        
        weakSelf.repostLastPage = nextCursor == 0;
        
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    } repostFailure:^(NSError *error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)getNewLikes
{
    
}

-(void)getOldLikes
{
    
}

#pragma mark - 加载view
-(void)loadView
{
    // 重新设置tableView时，应当重新调用下面的实例化方法。没法直接设置tableView.separatorStyle
    // 把 UITableView 的 style 属性设置为 Plain ，这个tableview的section header在滚动时会默认悬停在界面顶端。如果想取消悬停效果，可以修改 UITableView 的 style 属性设置为 Grouped. 这时所有的section header都会随着scrollview滚动了。不过 grouped 和 plain 的样式有轻微区别，切换样式后也许需要重新调整UI
    self.tableView = [[UITableView alloc] initWithFrame:kScreenFrame style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = kGlobalColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source & delegate method
#pragma mark 1、有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 判断上拉加载更多控件要不要显示
    if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
        self.tableView.mj_footer.hidden = _repostLastPage;
    }else if(self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
        self.tableView.mj_footer.hidden = _commentLastPage;
    }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
        self.tableView.mj_footer.hidden = _likeLastPage;
    }

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

#pragma mark 2、自定义section这组头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section? kDetailHeaderHeight : 0;
}

#pragma mark 3、每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSUInteger count = 0;
    
//    if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
//        count = self.statusRepostCellFrameM.count;
//    }else if(self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
//        count = self.statusCommentCellFrameM.count;
//    }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
//        count = self.statusLikeCellFrameM.count;
//    }
    
//    return section? count : 1;
    
    return section? [self currentFrames].count : 1;
}

#pragma mark 4、自定义indexPath这行cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat cellHeight = 0;
//    
//    if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
////        cellHeight = [self.statusRepostCellFrameM[indexPath.row] cellHeight];
//    }else if (self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
//        cellHeight = [self.statusCommentCellFrameM[indexPath.row] cellHeight];
//    }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
//        cellHeight = [self.statusLikeCellFrameM[indexPath.row] cellHeight];
//    }

//    return indexPath.section? cellHeight : self.statusDetailCellFrame.cellHeight;
    
    return indexPath.section? [[self currentFrames][indexPath.row] cellHeight] : self.statusDetailCellFrame.cellHeight;
}

#pragma mark 5、创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {// 微博详情cell
        cell = [StatusDetailCell statusDetailCellWithTableView:tableView statusDetailCellFrame:_statusDetailCellFrame];
    }else if (self.header.detailHeaderBtnType == kDetailHeaderRepostBtn) {
        cell = [StatusRepostCell statusRepostCellWithTableView:tableView statusRepostCellFrame:_statusRepostCellFrameM[indexPath.row]];
    }else if(self.header.detailHeaderBtnType == kDetailHeaderCommentBtn){
        cell = [StatusCommentCell statusCommentCellWithTableView:tableView statusCommentCellFrame:_statusCommentCellFrameM[indexPath.row]];
    }else if (self.header.detailHeaderBtnType == kDetailHeaderLikeBtn){
        
    }
    
    return cell;
}

#pragma mark 6、自定义section这组的头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (_header == nil) {
//        _header = [[DetailHeader alloc] init];
//        // 默认点击了“评论按钮”
//        _header.detailHeaderBtnType = kDetailHeaderCommentBtn;
//    }
    
    _header.status = _status;
    
    return section? _header : nil;
}

#pragma mark 判断tableView第indexPath行的cell能不能达到选中状态
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        StatusDetailVC *statusDetailVC = [[StatusDetailVC alloc] init];
//        
//        statusDetailVC.status = _statusDetailCellFrame.status.retweetedStatus;
//        
//        [self.navigationController pushViewController:statusDetailVC animated:YES];
//    }
//}

//#pragma mark 7.自定义section这组头部标题
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return section? @"评论／转发":@"微博";
//}



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
