//
//  SEMNewsViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMNewsViewController.h"
#import "SEMNewsVIewModel.h"
#import "BottomView.h"
#import "MDABizManager.h"
#import "LazyPageScrollView.h"
#import "TopicCell.h"
#import "NewsViewCell.h"
#import "SEMNewsDetailController.h"
@interface SEMNewsViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate>
@property (nonatomic,strong) SEMNewsVIewModel* viewModel;
@property (nonatomic,strong) UITableView* newstableview;
@property (nonatomic,strong) UITableView* topictableview;
@property (nonatomic,strong) UITableView* attensionTableview;
@property (nonatomic,strong) LazyPageScrollView* pageView;
@end

@implementation SEMNewsViewController

#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self addSubviews];
    [self makeConstraits];
}

- (void)addSubviews
{
    [self.view addSubview:self.pageView];
    [self.newstableview.mj_header beginRefreshing];
}

- (void)makeConstraits
{
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"资讯icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"资讯icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)bindModel
{
    self.title = self.viewModel.title;
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMNewsVIewModel alloc] initWithDictionary: routerParameters];
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
#pragma mark -Uitableviewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) //为什么会变成100
    {
        return self.viewModel.newsDataSource.count;
    }
    else if (tableView.tag == 101)
    {
        return self.viewModel.topicDataSource.count;
    }
    else  
    {
        return self.viewModel.attensionDatasource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        NewsViewCell* cell = (NewsViewCell*)[tableView dequeueReusableCellWithIdentifier:@"newscell" forIndexPath:indexPath];
        News* news = self.viewModel.newsDataSource[indexPath.row];
        
        cell.titleLabel.text = news.title;
        cell.bottomview.commentLabel.text = [@(news.commentCount) stringValue];;
        cell.bottomview.inifoLabel.text = [news getInfo];
        if (news.thumbnail.url)
        {
            NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
            [cell.newsImage sd_setImageWithURL:url
                              placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                       options:SDWebImageRefreshCached];
        }
        else
        {
            cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
        }
        return cell;
    }
    else if(tableView.tag == 101)
    {
        TopicCell* cell = (TopicCell*)[tableView dequeueReusableCellWithIdentifier:@"topiccell" forIndexPath:indexPath];
        Topic1* topic = self.viewModel.topicDataSource[indexPath.row];
        cell.title = topic.title;
        cell.titleImageURL = topic.thumbnail.url;
        cell.comment = [@(topic.commentCount) stringValue];
        cell.info = [topic getInfo];
        return cell;
    }
    else
    {
        NewsViewCell* cell = (NewsViewCell*)[tableView dequeueReusableCellWithIdentifier:@"attensioncell" forIndexPath:indexPath];
        News* news = self.viewModel.attensionDatasource[indexPath.row];
        
        cell.titleLabel.text = news.title;
        cell.bottomview.commentLabel.text = [@(news.commentCount) stringValue];;
        cell.bottomview.inifoLabel.text = [news getInfo];
        if (news.thumbnail.url)
        {
            NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
            [cell.newsImage sd_setImageWithURL:url
                              placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                       options:SDWebImageRefreshCached];
        }
        else
        {
            cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    if (tableView.tag == 101) {
        return scale * 258;
    }
    else
    {
        return scale * 100;

    }
}
#pragma mark- tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        NSInteger ide = self.viewModel.newsDataSource[indexPath.row].id;
        SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView.tag == 101)
    {
        NSInteger ide = self.viewModel.topicDataSource[indexPath.row].id;
        SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark -Getter

- (UITableView*)newstableview
{
    if (!_newstableview) {
        _newstableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _newstableview.delegate = self;
        _newstableview.dataSource = self;
        _newstableview.tag = 1;
        [_newstableview registerClass:[NewsViewCell class] forCellReuseIdentifier:@"newscell"];
        _newstableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewNewsCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"%@",x);
                [self.newstableview reloadData];
                NSLog(@"已经更新完了");
                [self endRefresh];
            }];
        }];
        _newstableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreNewsCommad execute: nil] subscribeNext:^(id x) {
                NSLog(@"已经加载了更多了");
                NSLog(@"%@",x);
                [_newstableview reloadData];
                [self endRefresh];
            }];
        }];
    }
    return _newstableview;
}
- (UITableView*)topictableview
{
    if (!_topictableview) {
        _topictableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _topictableview.delegate = self;
        _topictableview.dataSource = self;
        _topictableview.tag = 2;
        [_topictableview registerClass:[TopicCell class] forCellReuseIdentifier:@"topiccell"];
        _topictableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewTopicsCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"%@",x);
                [self.topictableview reloadData];
                NSLog(@"已经更新完了");
                [self endRefresh];
            }];
        }];
        _topictableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreTopicsCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"已经加载了更多了");
                NSLog(@"%@",x);
                [_topictableview reloadData];
                [self endRefresh];
            }];
        }];
        _topictableview.separatorInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _topictableview.separatorColor = [UIColor colorWithHexString:@"#F2F2F2"];
    }
    return _topictableview;
}

- (UITableView*)attensionTableview
{
    if (!_attensionTableview) {
        _attensionTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _attensionTableview.delegate = self;
        _attensionTableview.dataSource = self;
        _attensionTableview.tag = 3;
        [_attensionTableview registerClass:[NewsViewCell class] forCellReuseIdentifier:@"attensioncell"];
    }
    return _attensionTableview;
}
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.frame =self.view.frame;
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 3 TabHeight:40 VerticalDistance:10 BkColor:[UIColor whiteColor]];
        UIView *view=[[UIView alloc] init];
        view.backgroundColor=[UIColor orangeColor];
        [_pageView addTab:@"新闻" View:self.newstableview Info:nil];
        view=[[UIView alloc] init];
        view.backgroundColor=[UIColor greenColor];
        [_pageView addTab:@"话题" View:self.topictableview Info:nil];
        view=[[UIView alloc] init];
        view.backgroundColor=[UIColor lightGrayColor];
        [_pageView addTab:@"关注" View:self.attensionTableview Info:nil];
        [_pageView setTitleStyle:[UIFont systemFontOfSize:15] SelFont:[UIFont systemFontOfSize:20] Color:[UIColor blackColor] SelColor:[UIColor colorWithHexString:@"#1EA11F"]];
        [_pageView enableBreakLine:YES Width:1 TopMargin:0 BottomMargin:0 Color:[UIColor groupTableViewBackgroundColor]];
        [_pageView generate:^(UIButton *firstTitleControl, UIView *viewTitleEffect) {
            CGRect frame= firstTitleControl.frame;
            frame.size.height-=5;
            frame.size.width-=6;
            viewTitleEffect.frame=frame;
            viewTitleEffect.center=firstTitleControl.center;
        }];
        UIView *topView=[_pageView getTopContentView];
        UILabel *lb=[[UILabel alloc] init];
        lb.translatesAutoresizingMaskIntoConstraints=NO;
        lb.backgroundColor=[UIColor colorWithHexString:@"#"];
        [topView addSubview:lb];
        [topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lb)]];
        [topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb(==1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lb)]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //_pageView.selectedIndex=4;
            
        });
    }
    return _pageView;
}
- (void)endRefresh
{
    [self.newstableview.mj_footer endRefreshing];
    [self.newstableview.mj_header endRefreshing];
    [self.topictableview.mj_footer endRefreshing];
    [self.topictableview.mj_header endRefreshing];
    [self.attensionTableview.mj_footer endRefreshing];
    [self.attensionTableview.mj_header endRefreshing];
}
#pragma mark- pagescrollviewdeleagate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 1) {
        if (self.viewModel.fisrtGotoTopic == YES) {
            [self.topictableview.mj_header beginRefreshing];
        }
    }
    else if (index == 2)
    {
        if (self.viewModel.fisrtGotoAttension == YES) {
            [self.attensionTableview.mj_header beginRefreshing];
        }
    }
    
}


-(void)LazyPageScrollViewEdgeSwipe:(LazyPageScrollView *)pageScrollView Left:(BOOL)bLeft
{
    if(bLeft)
    {
        NSLog(@"left");
    }
    else
    {
        NSLog(@"right");
    }
}
@end
