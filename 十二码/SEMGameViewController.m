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
@interface SEMGameViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate>
@property (nonatomic,strong) LazyPageScrollView* pageView;
@property (nonatomic,strong)SEMGameVIewModel* viewModel;
@property (nonatomic,strong)UITableView* noticegameTableview;
@property (nonatomic,strong)UITableView* historygameTableview;
@property (nonatomic,strong)UITableView* gamelistTableview;
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
    if (tableView.tag == 101) {
        return 1;
    }
    else if (tableView.tag == 100)
    {
        return self.viewModel.noticeGameDatasource.count;
    }
    else{
        return self.viewModel.historyGameDatasource.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return self.viewModel.noticeGameDatasource[section].games.count;
    }
    else if (tableView.tag == 101)
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
    if(tableView.tag == 100)
    {
        NoticeGameviewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeGameviewCell" forIndexPath:indexPath];
        GameDetailModel* model1 = self.viewModel.noticeGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        cell.view.titleLabel.text = model.tournament.name;
        cell.view.roundLabel.text = model.round.name;
        cell.view.status = [model getStatus1];
        if (cell.view.status == 2) {
            cell.view.homeScoreLabel.text = @"-";
            cell.view.awaySocreLabel.text = @"-";
        }
        else
        {
            cell.view.homeScoreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.homeScore];
            cell.view.awaySocreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.awayScore];
        }
        cell.view.homeTitleLabel.text = model.home.name;
        cell.view.awayTitleLabel.text = model.away.name;
        cell.view.homeLabel.text = model.home.name;
        UIImage *image = [UIImage imageNamed:@"zhanwei.jpg"];
        NSURL *homeurl;
        if (model.home.logo.url) {
            homeurl = [[NSURL alloc] initWithString:model.home.logo.url];
            [cell.view.homeImageview sd_setImageWithURL:homeurl placeholderImage:image options:SDWebImageRefreshCached];
        }
        else
        {
            cell.view.homeImageview.image = image;
        }
        NSURL *awayurl;
        if (model.away.logo) {
            awayurl = [[NSURL alloc] initWithString:model.away.logo];
            [cell.view.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
        }
        else
        {
            cell.view.awayImgaeview.image = image;
        }
        cell.view.location = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else if (tableView.tag == 101)
    {
        GameListModel* model = self.viewModel.gameListDatasource[indexPath.row];
        GameListViewCell* cell = (GameListViewCell*)[tableView dequeueReusableCellWithIdentifier:@"GameListViewCell"];
        if (model.logo.url) {
            NSURL *url = [[NSURL alloc] initWithString:model.logo.url];
            [cell.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei"]];
            
        }
        else
        {
            cell.logoImageView.image = [UIImage imageNamed:@"zhanwei"];
        }
        cell.status = [model getStatus];
        cell.titleLabel.text = model.name;
        cell.timeLabel.text = [model getDate];
        cell.location = [model getLocation];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        return cell;
    }
    else
    {
        HistoryviewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryviewCell" forIndexPath:indexPath];
        GameDetailModel* model1 = self.viewModel.historyGameDatasource[indexPath.section];
        Games* model = model1.games[indexPath.row];
        cell.view.titleLabel.text = model.tournament.name;
        cell.view.roundLabel.text = model.round.name;
        cell.view.status = [model getStatus1];
        if (cell.view.status == 2) {
            cell.view.homeScoreLabel.text = @"-";
            cell.view.awaySocreLabel.text = @"-";
        }
        else
        {
            cell.view.homeScoreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.homeScore];
            cell.view.awaySocreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.awayScore];
        }
        cell.view.homeTitleLabel.text = model.home.name;
        cell.view.awayTitleLabel.text = model.away.name;
        cell.view.homeLabel.text = model.home.name;
        UIImage *image = [UIImage imageNamed:@"zhanwei.jpg"];
        NSURL *homeurl;
        if (model.home.logo.url) {
            homeurl = [[NSURL alloc] initWithString:model.home.logo.url];
            [cell.view.homeImageview sd_setImageWithURL:homeurl placeholderImage:image options:SDWebImageRefreshCached];
        }
        else
        {
            cell.view.homeImageview.image = image;
        }
        NSURL *awayurl;
        if (model.away.logo) {
            awayurl = [[NSURL alloc] initWithString:model.away.logo];
            [cell.view.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
        }
        else
        {
            cell.view.awayImgaeview.image = image;
        }
        cell.view.location = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        return 100 * self.view.scale;
    }
    else
    {
        return 156 * self.view.scale;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        return nil;
    }
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc] init];
    view.frame = CGRectMake(0, 0, self.view.width, 16*self.view.scale);
    [view addSubview:label];
    NSString* string;
    if (tableView.tag == 100) {
        string = [self.viewModel.noticeGameDatasource[section] getDate1];
    }
    else if(tableView.tag == 102)
    {
        string = [self.viewModel.historyGameDatasource[section] getDate1];
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = NSMakeRange(0, string.length);
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"#1EA11F"]
     
                          range:range];
    label.attributedText = AttributedStr;
    label.textAlignment = NSTextAlignmentCenter;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16*self.view.scale;
}
#pragma mark -tableviewDeleagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 101) {
        GameInfoDetailViewController* controller = [[GameInfoDetailViewController alloc] initWithDictionay:@{@"id":@(self.viewModel.gameListDatasource[indexPath.row].id)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView.tag == 100)
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
        _noticegameTableview.tag = 100;
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
    }
    return _noticegameTableview;
}
- (UITableView*)historygameTableview
{
    if (!_historygameTableview) {
        _historygameTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historygameTableview.delegate = self;
        _historygameTableview.dataSource = self;
        _historygameTableview.tag = 102;
        [_historygameTableview registerClass:[HistoryviewCell class] forCellReuseIdentifier:@"HistoryviewCell"];
        _historygameTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewHistoryGameCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"%@",x);
                [self.historygameTableview reloadData];
                NSLog(@"已经更新完了");
                [self endRefresh];
            }];
        }];
        _historygameTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreHistoryGameCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"已经加载了更多了");
                NSLog(@"%@",x);
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
    }
    return _historygameTableview;
}

- (UITableView*)gamelistTableview
{
    if (!_gamelistTableview) {
        _gamelistTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _gamelistTableview.delegate = self;
        _gamelistTableview.dataSource = self;
        _gamelistTableview.tag = 101;
        [_gamelistTableview registerClass:[GameListViewCell class] forCellReuseIdentifier:@"GameListViewCell"];
        _gamelistTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [[self.viewModel.loadNewGameListCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"%@",x);
                [self.gamelistTableview reloadData];
                NSLog(@"已经更新完了");
                [self endRefresh];
            }];
        }];
        _gamelistTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [[self.viewModel.loadMoreGameListCommand execute: nil] subscribeNext:^(id x) {
                NSLog(@"已经加载了更多了");
                NSLog(@"%@",x);
                [_gamelistTableview reloadData];
                [self endRefresh];
            }];
        }];
    }
    return _gamelistTableview;
}
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 3 TabHeight:40 VerticalDistance:10 BkColor:[UIColor whiteColor]];
        UIView *view=[[UIView alloc] init];
        view.backgroundColor=[UIColor orangeColor];
        [_pageView addTab:@"比赛预告" View:self.noticegameTableview Info:nil];
        view=[[UIView alloc] init];
        view.backgroundColor=[UIColor greenColor];
        [_pageView addTab:@"赛事一览" View:self.gamelistTableview Info:nil];
        view=[[UIView alloc] init];
        view.backgroundColor=[UIColor lightGrayColor];
        [_pageView addTab:@"历史战报" View:self.historygameTableview Info:nil];
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
    if (index == 1) {
        if (self.viewModel.fisrtGotoGameListtable == YES) {
            [self.gamelistTableview.mj_header beginRefreshing];
        }
    }
    else if (index == 2)
    {
        if (self.viewModel.fisrtGotoHistoryTable == YES) {
            [self.historygameTableview.mj_header beginRefreshing];
        }
    }
    
}

@end
