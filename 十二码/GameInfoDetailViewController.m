//
//  GameInfoDetailViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameInfoDetailViewController.h"
#import "SEMTeamHomeViewController.h"
#import "SEMTeamHomeModel.h"
#import "MDABizManager.h"
#import "LazyPageScrollView.h"
#import "MessageTableviewCell.h"
#import "TeamNewsCell.h"
#import "TeamHomeModelResponse.h"
#import "ShareView.h"
#import "CommentCell.h"
#import "NoticeGameviewCell.h"
#import "CostomView.h"
#import "SEMTeamPhotoController.h"
#import "TeamDetailInfoView.h"
#import "PlayerDetailViewController.h"
#import "SEMNewsDetailController.h"
#import "GameinfoViewModel.h"
@interface GameInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,ShareViewDelegate>
@property (nonatomic,strong) GameinfoViewModel  * viewModel;
@property (nonatomic,strong) UIImageView        * logoImageView;
@property (nonatomic,strong) LazyPageScrollView * pageView;
@property (nonatomic,strong) UITableView        * infoTableView;
@property (nonatomic,strong) UITableView        * gameTableView;
@property (nonatomic,strong) UITableView        * listTableview;
@property (nonatomic,strong) UITableView        * teamTableView;
@property (nonatomic,strong) MBProgressHUD      * hud;
@property (nonatomic,strong) UIBarButtonItem    * shareItem;
@property (nonatomic,strong) UIBarButtonItem    * favoriteItem;
@property (nonatomic,strong) UIBarButtonItem    * blankItem;
@property (nonatomic,strong) ShareView          * shareView;
@property (nonatomic,strong) UIView             * maskView;
@property (nonatomic,strong) UIBarButtonItem    * backItem;
@end

@implementation GameInfoDetailViewController
- (instancetype)initWithDictionay:(NSDictionary *)dictionary
{
    self = [super initWithDictionay:dictionary];
    if (self) {
        self.viewModel = [[GameinfoViewModel alloc] initWithDictionary:dictionary];
    }
    return self;
}
#pragma mark- lifeCycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark- setview
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubviews];
    [self makeConstraits];
}
- (void)addSubviews
{
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.pageView];
    self.navigationItem.rightBarButtonItems = @[self.shareItem,self.blankItem,self.favoriteItem];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.hud.labelText = @"加载中";
}

- (void)makeConstraits
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@(227 *self.view.scale));
    }];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
- (void)bindModel
{
    //当加载完毕之后隐藏hud
    [RACObserve(self.viewModel, status) subscribeNext:^(id x) {
        if (self.viewModel.status == 3) {
            [self.hud hide:YES];
            self.navigationItem.title = self.viewModel.model.name;
            if (self.viewModel.model.logo.url) {
                [self.logoImageView sd_setImageWithURL:[[NSURL alloc] initWithString:self.viewModel.model.logo.url]  placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.logoImageView.image = [UIImage placeholderImage];
            }
            [self.gameTableView reloadData];
            [self.teamTableView reloadData];
            [self.infoTableView reloadData];
        }
    }];
    [[self.viewModel.shareCommand executionSignals] subscribeNext:^(id x) {
        NSLog(@"收到了分享信号");
        CALayer* imageLayer = self.shareView.layer;
        self.maskView.hidden = NO;
        CGPoint fromPoint = imageLayer.position;
        CGPoint toPoint = CGPointMake(0, self.view.height - 200*self.view.scale);
        // 创建不断改变CALayer的position属性的属性动画
        CABasicAnimation* anim = [CABasicAnimation
                                  animationWithKeyPath:@"position"];
        // 设置动画开始的属性值
        anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
        // 设置动画结束的属性值
        anim.toValue = [NSValue valueWithCGPoint:toPoint];
        anim.duration = 0.3;
        imageLayer.position = toPoint;
        anim.removedOnCompletion = YES;
        // 为imageLayer添加动画
        [imageLayer addAnimation:anim forKey:nil];
    }];
    [RACObserve(self.logoImageView, frame) subscribeNext:^(id x) {
        if (self.pageView.frame.origin.y < -44) {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
        }
    }];
}
- (void)hideMaskView
{
    _maskView.hidden = YES;
    CALayer* imageLayer = self.shareView.layer;
    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(0, self.view.height);
    // 创建不断改变CALayer的position属性的属性动画
    CABasicAnimation* anim = [CABasicAnimation
                              animationWithKeyPath:@"position"];
    // 设置动画开始的属性值
    anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    // 设置动画结束的属性值
    anim.toValue = [NSValue valueWithCGPoint:toPoint];
    anim.duration = 0.3;
    imageLayer.position = toPoint;
    anim.removedOnCompletion = YES;
    // 为imageLayer添加动画
    [imageLayer addAnimation:anim forKey:nil];
}
#pragma mark- shareviewdelegate
- (void)didSelectedShareView:(NSInteger)index
{
    switch (index) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            [self hideMaskView];
            break;
        default:
            break;
    }
}
#pragma mark- tableiviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {

        if (self.viewModel.model) {
            return 2;
        }
    }
    else if (tableView.tag == 101)
    {
        return self.viewModel.scheduleModel.latestsrounds.count;
    }
    else if (tableView.tag == 102)
    {
        return 0;
        
    }
    else if(tableView.tag == 103)
    {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        if (self.viewModel.model) {
            return [self.viewModel.infoTableviewRowNumber[section] integerValue];
        }
    }
    else if (tableView.tag == 101)
    {
        return self.viewModel.scheduleModel.latestsrounds[section].games.count;
    }
    else if (tableView.tag == 102)
    {
        return 0;
    }
    else if(tableView.tag == 103)
    {
        return self.viewModel.teamModel.count;
    }

    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        if (self.viewModel.model) {
            if (indexPath.section == 0) {
                BasicInfoCell* cell = (BasicInfoCell*)[tableView dequeueReusableCellWithIdentifier:@"BasicInfoCell"];
                cell.text = self.viewModel.model.desc;
                return cell;
            }
            else
            {
                UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infoCell"];
                cell.textLabel.text = self.viewModel.infotableviewCellname[indexPath.row];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"A1B2BA"];
                cell.detailTextLabel.text = self.viewModel.infoTableViewCellInfo[indexPath.row];
                [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView.mas_left).offset(98*self.view.scale);
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                }];
                return cell;
            }
        }
    }
    else if (tableView.tag == 101)
    {
        NoticeGameviewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeGameviewCell" forIndexPath:indexPath];
        Games* model = self.viewModel.scheduleModel.latestsrounds[indexPath.section].games[indexPath.row];
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
    else if (tableView.tag == 102)
    {
        return nil;
    }
    else if (tableView.tag == 103)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"teamCell"];
        cell.textLabel.text = self.viewModel.teamModel[indexPath.row].name;
        cell.textLabel.textColor = [UIColor MyColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        return 156 * self.view.scale;
    }
    else if(tableView.tag == 103)
    {
        return 48 *self.view.scale;
    }
    else if (tableView.tag == 100)
    {
        if (self.viewModel.model) {
            if (indexPath.section == 0) {
                return [tableView cellHeightForIndexPath:indexPath model:self.viewModel.model.desc keyPath:@"text" cellClass:[BasicInfoCell class] contentViewWidth:self.view.width];
            }
            else
            {
                return 48*self.view.scale;
            }
        }
       
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        return 30*self.view.scale;
    }
    else if (tableView.tag == 100)
    {
        return 44*self.view.scale;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (tableView.tag == 101) {
        UIView* view = [UIView new];
        view.backgroundColor = [UIColor BackGroundColor];
        UILabel* label = [UILabel new];
        label.text = self.viewModel.scheduleModel.latestsrounds[section].name;
        label.backgroundColor =[UIColor BackGroundColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.sd_layout
        .rightEqualToView(view)
        .centerYEqualToView(view)
        .leftEqualToView(view)
        .heightIs(30*self.view.scale);
        return view;
    }
    else if (tableView.tag == 100)
    {
        UIView* view = [UIView new];
        UILabel* label = [UILabel new];
        if (section == 0) {
            label.text = @"基本资料";
        }
        else
        {
            label.text = @"赛事章程";
        }
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor MyColor];
        label.sd_layout
        .rightEqualToView(view)
        .centerYEqualToView(view)
        .leftSpaceToView(view,10)
        .heightIs(30*self.view.scale);
        return view;
    }
    return nil;
    
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
#pragma  mark- scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < 175) {
        [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(-offset);
            make.left.and.right.equalTo(self.view);
            make.height.equalTo(@(227 *self.view.scale));
        }];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    if(offset > 175)
    {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_topLayoutGuide);
            make.left.and.right.equalTo(self.view);
            make.height.equalTo(@(227 *self.view.scale));
        }];
    }
}
#pragma mark- getter
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.frame =self.view.frame;
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 4 TabHeight:40 VerticalDistance:10 BkColor:[UIColor whiteColor]];
        [_pageView addTab:@"简介" View:self.infoTableView Info:nil];
        [_pageView addTab:@"赛程" View:self.gameTableView Info:nil];
        [_pageView addTab:@"榜单" View:self.listTableview Info:nil];
        [_pageView addTab:@"球队" View:self.teamTableView Info:nil];
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
- (UITableView*)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.tag = 100;
        _infoTableView.separatorColor = [UIColor whiteColor];
        [_infoTableView registerClass:[BasicInfoCell class] forCellReuseIdentifier:@"BasicInfoCell"];
    }
    return _infoTableView;
}
- (UITableView*)gameTableView
{
    if (!_gameTableView) {
        _gameTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _gameTableView.delegate = self;
        _gameTableView.dataSource = self;
        _gameTableView.tag = 101;
        [_gameTableView registerClass:[NoticeGameviewCell class] forCellReuseIdentifier:@"NoticeGameviewCell"];
    }
    return _gameTableView;
}
- (UITableView*)listTableview
{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableview.delegate = self;
        _listTableview.dataSource = self;
        _listTableview.tag = 102;
    }
    return _listTableview;
}
- (UITableView*)teamTableView
{
    if (!_teamTableView) {
        _teamTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _teamTableView.delegate = self;
        _teamTableView.dataSource = self;
        _teamTableView.tag = 103;
    }
    return _teamTableView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _logoImageView.clipsToBounds = YES;
        
    }
    return _logoImageView;
}
-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}
- (ShareView *)shareView
{
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, 200*self.view.scale)];
        _shareView.layer.anchorPoint = CGPointMake(0, 0);
        _shareView.frame = CGRectMake(0, self.view.height, self.view.width, 200*self.view.scale);
        _shareView.delegate = self;
        _shareView.layer.anchorPoint = CGPointMake(0, 0);
        NSLog(@"%@",_shareView.description);
    }
    return _shareView;
}
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0.5;
        _maskView.hidden = YES;
        
        //添加点击之后的手势
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
-(UIBarButtonItem *)shareItem
{
    if (!_shareItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 20, 25);
        
        [button setImage:[UIImage imageNamed:@"upload_L"] forState:UIControlStateNormal];
        _shareItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.rac_command = self.viewModel.shareCommand;
    }
    return _shareItem;
}
- (UIBarButtonItem *)favoriteItem
{
    if (!_favoriteItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 0, 25, 25);
        [button setImage:[UIImage imageNamed:@"star_L"] forState:UIControlStateNormal];
        _favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.rac_command = self.viewModel.likeCommand;
    }
    return _favoriteItem;
}
- (UIBarButtonItem *)blankItem
{
    if (!_blankItem) {
        _blankItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        _blankItem.width = 20;
    }
    return _blankItem;
}
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 25, 20);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
#pragma mark -LazyPageScrollViewDelegate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 1) {
        [self.gameTableView reloadData];
    }
    else if (index == 2)
    {
        [self.listTableview reloadData];
    }
    else if (index == 0)
    {
        [self.infoTableView reloadData];
    }
    else if (index == 3)
    {
        [self.teamTableView reloadData];
    }
}

@end

