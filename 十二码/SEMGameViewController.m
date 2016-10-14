//
//  SEMGameViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMGameViewController.h"
#import "SEMGameVIewModel.h"
#import "LazyPageScrollView.h"
#import "GameListViewCell.h"
#import "HistoryviewCell.h"
#import "NoticeGameviewCell.h"
#define NOTICETABLEVIEW 100
#define HISTORYTABLEVIEW 101
#define GAMELISTTABLEVIEW 102
@interface SEMGameViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate>
@property (nonatomic,strong) LazyPageScrollView * pageView;
@property (nonatomic,strong) SEMGameVIewModel   * viewModel;
@property (nonatomic,strong) UITableView        * noticegameTableview;
@property (nonatomic,strong) UITableView        * historygameTableview;
@property (nonatomic,strong) UITableView        * gamelistTableview;
@end

@implementation SEMGameViewController


#pragma mark- lifeCycle
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
}

- (void)addSubviews
{
    [self.view addSubview:self.pageView];
    [self.noticegameTableview.mj_header beginRefreshing];
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
- (void)bindModel
{
    self.title = self.viewModel.title;
}
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"赛事icon=灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"赛事icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"赛事" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMGameVIewModel alloc] initWithDictionary: routerParameters];
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

#pragma mark- tableviewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == GAMELISTTABLEVIEW) {
        return 1;
    }
    else if (tableView.tag == NOTICETABLEVIEW)
    {
        return self.viewModel.noticeGameDatasource.count;
    }
    else{
        return self.viewModel.historyGameDatasource.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == NOTICETABLEVIEW) {
        return self.viewModel.noticeGameDatasource[section].games.count;
    }
    else if (tableView.tag == GAMELISTTABLEVIEW)
    {
        return self.viewModel.gameListDatasource.count;
    }
    else
    {
        return self.viewModel.historyGameDatasource[section].games.count;

    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == NOTICETABLEVIEW)
    {
        NoticeGameviewCell* cell = [[NoticeGameviewCell alloc] init];
        GameDetailModel* model1 = self.viewModel.noticeGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        cell.model = model;
        return cell;

    }
    else if (tableView.tag == GAMELISTTABLEVIEW)
    {
        GameListModel* model = self.viewModel.gameListDatasource[indexPath.row];
        GameListViewCell* cell = (GameListViewCell*)[tableView dequeueReusableCellWithIdentifier:@"GameListViewCell"];
        if (model.logo.url) {
            NSString* encodedString = [model.logo.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [[NSURL alloc] initWithString:encodedString];
            [cell.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei"]];
        }
        else
        {
            cell.logoImageView.image = [UIImage imageNamed:@"zhanwei"];
        }
        cell.status = [model getStatus];
        cell.titleLabel.text = model.name;
        cell.timeLabel.text = [model getDate];
        cell.location = model.university.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }
    else
    {
        NoticeGameviewCell* cell = [[NoticeGameviewCell alloc] init];
        GameDetailModel* model1 = self.viewModel.historyGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        cell.model = model;
        return cell;
        
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == GAMELISTTABLEVIEW) {
        return 120 * self.view.scale;
    }
    else if(tableView.tag == HISTORYTABLEVIEW)
    {
        GameDetailModel* model1 = self.viewModel.historyGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        if (model.latestNews.detail) {
            return 196 * self.view.scale;
        }
        return 156*self.view.scale;
   
    }else{
        GameDetailModel* model1 = self.viewModel.noticeGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        if (model.latestNews.detail) {
            return 196 * self.view.scale;
        }
        return 156*self.view.scale;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == GAMELISTTABLEVIEW) {
        return nil;
    }
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc] init];
    view.frame = CGRectMake(0, 0, self.view.width, 16*self.view.scale);
    [view addSubview:label];
    NSString* string;
    if (tableView.tag == NOTICETABLEVIEW) {
        string = [self.viewModel.noticeGameDatasource[section] getDate1];
    }
    else if(tableView.tag == HISTORYTABLEVIEW)
    {
        string = [self.viewModel.historyGameDatasource[section] getDate1];
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = NSMakeRange(0, string.length);
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"#999999"]
     
                          range:range]  ;
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*self.view.scale] range:range];
    label.attributedText = AttributedStr;
    label.textAlignment = NSTextAlignmentCenter;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.height.equalTo(view.mas_height);
    }];
    view.backgroundColor = [UIColor BackGroundColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag != GAMELISTTABLEVIEW) {
        return 60*self.view.scale;
    }
    return 0;
}
#pragma mark -tableviewDeleagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == GAMELISTTABLEVIEW) {
        GameInfoDetailViewController* controller = [[GameInfoDetailViewController alloc] initWithDictionay:@{@"id":@(self.viewModel.gameListDatasource[indexPath.row].id)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView.tag == NOTICETABLEVIEW)
    {
        RaceInfoDetailController* controller = [[RaceInfoDetailController alloc] initWithDictionay:@{@"id":@(self.viewModel.noticeGameDatasource[indexPath.section].games[indexPath.row].id)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        RaceInfoDetailController* controller = [[RaceInfoDetailController alloc] initWithDictionay:@{@"id":@(self.viewModel.historyGameDatasource[indexPath.section].games[indexPath.row].id)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark- Getter
- (UITableView*)noticegameTableview
{
    if (!_noticegameTableview) {
        _noticegameTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _noticegameTableview.delegate = self;
        _noticegameTableview.dataSource = self;
        _noticegameTableview.tag = NOTICETABLEVIEW;
        [_noticegameTableview registerClass:[NoticeGameviewCell class] forCellReuseIdentifier:@"NoticeGameviewCell"];
        _noticegameTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewNoticeGameCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"%@",x);
                [self.noticegameTableview reloadData];
                NSLog(@"已经更新完了");
                [self endRefresh];
            }];
        }];
        _noticegameTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreNoticeGameCommad execute: nil] subscribeNext:^(id x) {
                NSLog(@"已经加载了更多了");
                NSLog(@"%@",x);
                [_noticegameTableview reloadData];
                [self endRefresh];
            }];
        }];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _noticegameTableview.tableHeaderView = backView;
        _noticegameTableview.backgroundColor = [UIColor BackGroundColor];
        _noticegameTableview.separatorColor = [UIColor BackGroundColor];
    }
    return _noticegameTableview;
}
- (UITableView*)historygameTableview
{
    if (!_historygameTableview) {
        _historygameTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historygameTableview.delegate = self;
        _historygameTableview.dataSource = self;
        _historygameTableview.tag = HISTORYTABLEVIEW;
        [_historygameTableview registerClass:[HistoryviewCell class] forCellReuseIdentifier:@"HistoryviewCell"];
        _historygameTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewHistoryGameCommand execute: nil] subscribeNext:^(id x) {
                [self.historygameTableview reloadData];
                [self endRefresh];
            }];
        }];
        _historygameTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreHistoryGameCommand execute: nil] subscribeNext:^(id x) {
                [_historygameTableview reloadData];
                [self endRefresh];
            }];
        }];
        _historygameTableview.separatorInset = UIEdgeInsetsMake(8, 8, 8, 8);
        _historygameTableview.separatorColor = [UIColor colorWithHexString:@"#F2F2F2"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _historygameTableview.tableHeaderView = backView;
        _historygameTableview.backgroundColor = [UIColor BackGroundColor];
        _historygameTableview.separatorColor = [UIColor BackGroundColor];
    }
    return _historygameTableview;
}

- (UITableView*)gamelistTableview
{
    if (!_gamelistTableview) {
        _gamelistTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _gamelistTableview.delegate = self;
        _gamelistTableview.dataSource = self;
        _gamelistTableview.tag = GAMELISTTABLEVIEW;
        [_gamelistTableview registerClass:[GameListViewCell class] forCellReuseIdentifier:@"GameListViewCell"];
        _gamelistTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewGameListCommand execute: nil] subscribeNext:^(id x) {
                [self.gamelistTableview reloadData];
                [self endRefresh];
            }];
        }];
        _gamelistTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreGameListCommand execute: nil] subscribeNext:^(id x) {
                [_gamelistTableview reloadData];
                [self endRefresh];
            }];
        }];
        _gamelistTableview.backgroundColor = [UIColor BackGroundColor];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _gamelistTableview.tableHeaderView = backView;
        _gamelistTableview.backgroundColor = [UIColor BackGroundColor];
        _gamelistTableview.separatorColor = [UIColor BackGroundColor];
    }
    return _gamelistTableview;
}
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 3 TabHeight:45*self.view.scale VerticalDistance:0 BkColor:[UIColor whiteColor]];
        [_pageView addTab:@"比赛预告" View:self.noticegameTableview Info:nil];
        [_pageView addTab:@"历史战报" View:self.historygameTableview Info:nil];
        [_pageView addTab:@"赛事一览" View:self.gamelistTableview Info:nil];
        [_pageView setTitleStyle:[UIFont systemFontOfSize:15*self.view.scale] SelFont:[UIFont systemFontOfSize:18*self.view.scale] Color:[UIColor colorWithHexString:@"#666666"] SelColor:[UIColor colorWithHexString:@"#1EA11F"]];
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
    [self.noticegameTableview.mj_footer endRefreshing];
    [self.noticegameTableview.mj_header endRefreshing];
    [self.historygameTableview.mj_footer endRefreshing];
    [self.historygameTableview.mj_header endRefreshing];
    [self.gamelistTableview.mj_footer endRefreshing];
    [self.gamelistTableview.mj_header endRefreshing];
}
#pragma mark- pagescrollviewdeleagate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 2) {
        if (self.viewModel.fisrtGotoGameListtable == YES) {
            [self.gamelistTableview.mj_header beginRefreshing];
        }
    }
    else if (index == 1)
    {
        if (self.viewModel.fisrtGotoHistoryTable == YES) {
            [self.historygameTableview.mj_header beginRefreshing];
        }
    }
    
}

@end
