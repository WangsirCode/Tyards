//
//  SEMHomeVIewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMHomeVIewController.h"
#import "SEMHomeVIewModel.h"
#import "SEMNetworkingManager.h"
#import "SDCycleScrollView.h"
#import "HomeCell.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "ReCommendNews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYCategories.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HomeHeadView.h"
#import "MJRefresh.h"
#import <ReactiveViewModel/ReactiveViewModel.h>
#import "HRTRouter.h"
#import "SEMSearchViewController.h"
#import "MMDrawerController.h"
#import "UserModel.h"
#import "UIViewController+MMDrawerController.h"
#import "MDABizManager.h"
#import "SEMTabViewController.h"
#import "SEMNewsDetailController.h"
#import "UIView+redPoint.h"
@interface SEMHomeVIewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SEMSearchViewControllerDelegate>
@property (nonatomic,strong) SEMHomeVIewModel * viewModel;
@property (nonatomic,strong) HomeHeadView     * headView;
@property (nonatomic,strong) UITableView      * tableView;
@property (nonatomic,strong) UIBarButtonItem  * searchItem;
@property (nonatomic,strong) UIBarButtonItem  * userItem;
@property (nonatomic,strong) UIButton         * button;
@property (nonatomic,strong) UIView           * userView;
@property (nonatomic,strong) UIView           * red;
@end

@implementation SEMHomeVIewController


#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage* model = (UIImage*)[DataArchive unarchiveUserDataWithFileName:@"headimage"];
    if (model)
    {
        [self.button setImage:model forState:UIControlStateNormal];
    }
    else
    {
        [self.button setImage:[UIImage imageNamed:@"Group 2"] forState:UIControlStateNormal];
    }
    if ([self.viewModel haveUnredMessge]) {
        self.red.hidden = NO;
    }
    else
    {
        self.red.hidden = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
    
}

- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"首页icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"首页icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)addSubviews
{
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.searchItem;
    self.navigationItem.leftBarButtonItem = self.userItem;
    [self.button showRedAtOffSetX:10 AndOffSetY:10 OrValue:@"1"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        
        [[self.viewModel.loadNewCommand execute: nil] subscribeNext:^(id x) {
            if ([x  isEqual: @1]) {
                [self.tableView reloadData];
            }
            else
            {
                //设置轮播图
                NSMutableArray* titles = [[NSMutableArray alloc] init];
                NSMutableArray* url = [[NSMutableArray alloc]init];
                [self.viewModel.topics enumerateObjectsUsingBlock:^(Topic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [titles addObject:obj.title];
                    [url addObject:obj.media.url];
                }];
                self.headView.scrollView.titlesGroup = titles;
                self.headView.scrollView.imageURLStringsGroup = url;
                self.headView.scrollView.placeholderImage = [UIImage placeholderImage];
            }
            NSLog(@"已经更新完了");
            [self endRefresh];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[self.viewModel.loadMoreCommand execute: nil] subscribeNext:^(id x) {
            NSLog(@"已经加载了更多了");
            NSLog(@"%@",x);
            [self.tableView reloadData];
            [self endRefresh];
        
        }];
        
    }];
}
- (void)endRefresh
{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}
- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.left.bottom.equalTo(self.view);
    }];
}

- (void)bindModel
{
    [RACObserve(self.viewModel, title) subscribeNext:^(NSString* x) {
        self.navigationItem.title = x;
    }];
    self.searchItem.rac_command = self.viewModel.searchCommand;
    [self.searchItem.rac_command.executionSignals subscribeNext:^(id x) {
        SEMSearchViewController* searchControlle = [HRTRouter objectForURL:@"search" withUserInfo:@{}];
        searchControlle.delegate = self;
        [self.navigationController pushViewController:searchControlle animated:true];
    }];
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMHomeVIewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark -initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTab];
    }
    return self;
}

#pragma mark -searchcontrollerDelegate
- (void)didSelectedItem:(NSString *)name diplayname:(NSString *)dispalyname uni:(Universities *)uni
{
    self.viewModel.code = name;
    [DataArchive archiveData:name withFileName:@"school"];
    self.viewModel.title = dispalyname;
    NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
    [database setObject:name forKey:@"name"];
    [database setObject:dispalyname forKey:@"displayname"];
    
    [self.tableView.mj_header beginRefreshing];
    SEMTabViewController* nav = ((SEMTabViewController*)self.mm_drawerController.centerViewController);
    nav.viewControllers = [NSArray arrayWithObjects:[HRTRouter objectForURL: @"Home?navigation=navigation"],[HRTRouter objectForURL: @"News?navigation=navigation"],[HRTRouter objectForURL: @"Team?navigation=navigation"],[HRTRouter objectForURL: @"Game?navigation=navigation"], nil];
}
#pragma mark -tableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News* news = self.viewModel.datasource[indexPath.row];
    HomeCell* cell = [[HomeCell alloc] init];
    cell.model = news;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    return 120*scale;
    
}
#pragma mark -Scollviewdelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSInteger ide = self.viewModel.topics[index].id;
    Topic *news=self.viewModel.topics[index];
    SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide),@"hot":@"YES"}];
    controller.hidesBottomBarWhenPushed = YES;
    controller.shareTitle=news.title;
    controller.shareImgUrl =news.media.url;
    controller.shareId=ide;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark- tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ide = self.viewModel.datasource[indexPath.row].id;
    News* news = self.viewModel.datasource[indexPath.row];
    SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
    controller.hidesBottomBarWhenPushed = YES;
    controller.shareTitle=news.title;
    controller.shareImgUrl =news.thumbnail.url;
    controller.shareId=ide;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark -Getter
- (HomeHeadView*)headView
{
    if(!_headView)
    {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 2)];
        _headView.scrollView.delegate = self;
        _headView.backgroundColor = [UIColor whiteColor];
        if (self.viewModel.topics) {
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            NSMutableArray* url = [[NSMutableArray alloc]init];
            [self.viewModel.topics enumerateObjectsUsingBlock:^(Topic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:obj.title];
                [url addObject:obj.media.url];
            }];
            self.headView.scrollView.titlesGroup = titles;
            self.headView.scrollView.imageURLStringsGroup = url;
        }
        
    }
    return _headView;
}
- (UITableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
        
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor BackGroundColor];
        _tableView.separatorColor = [UIColor BackGroundColor];
    }
    return _tableView;
}
- (UIBarButtonItem*)searchItem
{
    if(!_searchItem)
    {
        _searchItem = [[UIBarButtonItem alloc] initWithTitle:@"切换学校" style:UIBarButtonItemStylePlain target:nil action:nil];
        [_searchItem setTintColor:[UIColor whiteColor]];
    }
    return _searchItem;
}
- (UIBarButtonItem*)userItem
{
    if (!_userItem) {
        _userItem = [[UIBarButtonItem alloc] initWithCustomView:self.userView];
        
        [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                
            }];
        }];
    }
    return _userItem;
}
- (UIButton*)button
{
    if (!_button) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 30, 30);
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 15;
    }
    return _button;
}
- (UIView *)userView
{
    if (!_userView) {
        _userView = [UIView new];
        [_userView addSubview:self.button];
        _userView.frame = CGRectMake(0, 0, 30, 30);
        [_userView addSubview:self.red];
    }
    return _userView;
}
- (UIView *)red
{
    if (!_red) {
        _red = [UIView new];
        _red.backgroundColor = [UIColor redColor];
        _red.frame = CGRectMake(25, 0, 9, 9);
        _red.layer.cornerRadius = _red.width / 2;
        _red.clipsToBounds = YES;
    }
    return _red;
}
@end
