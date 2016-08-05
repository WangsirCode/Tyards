//
//  SEMTeamHomeViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamHomeViewController.h"
#import "SEMTeamHomeModel.h"
#import "MDABizManager.h"
#import "LazyPageScrollView.h"
#import "MessageTableviewCell.h"
#import "TeamNewsCell.h"
#import "TeamHomeModelResponse.h"
#import "ShareView.h"
@interface SEMTeamHomeViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,ShareViewDelegate>
@property (nonatomic,strong)SEMTeamHomeModel* viewModel;
@property (nonatomic,strong)UIImageView* logoImageView;
@property (nonatomic,strong) LazyPageScrollView* pageView;
@property (nonatomic,strong)UITableView* messageTableview;
@property (nonatomic,strong)UITableView* newsTableview;
@property (nonatomic,strong)UITableView* listTableview;
@property (nonatomic,strong)UITableView* scheduleTableview;
@property (nonatomic,strong)UITableView* infoTableview;
@property (nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic,strong)UIBarButtonItem* shareItem;
@property (nonatomic,strong)UIBarButtonItem* favoriteItem;
@property (nonatomic,strong)UIBarButtonItem* blankItem;
@property (nonatomic,strong)ShareView* shareView;
@property (nonatomic,strong)UIView* maskView;
@end

@implementation SEMTeamHomeViewController
#pragma mark- lifeCycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
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
    [RACObserve(self.viewModel, finishenLoading) subscribeNext:^(id x) {
        if (self.viewModel.finishenLoading == YES) {
            [self.hud hide:YES];
            self.navigationItem.title = self.viewModel.model.info.name;
            NSString* urlstring = self.viewModel.model.info.cover.url;
            if (urlstring) {
                NSURL* url = [[NSURL alloc] initWithString:urlstring];
                [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
            }
            else
            {
                self.logoImageView.image = [UIImage placeholderImage];
            }
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
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMTeamHomeModel alloc] initWithDictionary: routerParameters];
}

#pragma mark- shareviewdelegate
- (void)didSelectedShareView:(NSInteger)index
{
//    NSLog(@"%ld",(long)index);
//    WXMediaMessage* mes = [WXMediaMessage message];
//    [mes setThumbImage:[UIImage imageNamed:@"zhanwei.jpg"]];
//    mes.title = self.viewModel.newdetail.title;
//    mes.description = @"我在十二码发送了一片文章";
//    WXWebpageObject* web = [WXWebpageObject object];
//    web.webpageUrl = @"www.baidu.com";
//    mes.mediaObject = web;
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.scene = WXSceneTimeline;
    switch (index) {
        case 0:
            break;
        case 1:
//            [WXApi sendReq:req];
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
        return 1;
    }
    else if (tableView.tag == 101)
    {
        return 1;
    }
    else if (tableView.tag == 102)
    {
        if(self.viewModel.model.info.coach)
        {
          return 2;
        }
        else
        {
            return 1;
        }
        
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return 0;
    }
    else if (tableView.tag == 101)
    {
        return self.viewModel.model.articles.count;
    }
    else if (tableView.tag == 102)
    {
        if (self.viewModel.model.info.coach) {
            switch (section) {
                case 0:
                    return 1;
                    break;
                case 1:
                    return self.viewModel.players.count;
                    break;
                default:
                    break;
            }
        }
        else
        {
            return self.viewModel.players.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        
    }
    else if (tableView.tag == 101)
    {
        Articles* news = self.viewModel.model.articles[indexPath.row];
        TeamNewsCell* cell = (TeamNewsCell*)[tableView dequeueReusableCellWithIdentifier:@"TeamNewsCell"];
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
    else if (tableView.tag == 102)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TeamPlayerCell"];
        NSString* cap = self.viewModel.model.info.captain;
        if (indexPath.section == 0 && self.viewModel.model.info.coach)
        {
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithString:self.viewModel.model.info.coach];
            NSRange range = NSMakeRange(0, self.viewModel.model.info.coach.length);
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#1EA11F"] range:range];
            cell.textLabel.attributedText = attr;
        }
        else if ((indexPath.section == 0) && (indexPath.row == 0) && cap)
        {
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithString:cap];
            NSRange range = NSMakeRange(0, self.viewModel.model.info.coach.length);
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#1EA11F"] range:range];
            cell.textLabel.attributedText = attr;
            cell.detailTextLabel.text = @"教练";
        }
        else
        {
            cell.textLabel.text = self.viewModel.players[indexPath.row].player.name;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        
    }
    else if(tableView.tag == 101)
    {
        return 100 * self.view.scale;
    }
    else if (tableView.tag == 102)
    {
        return 48 * self.view.scale;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 102) {
        if (section == 0 && self.viewModel.model.info.coach) {
            return @"主教练";
        }
        else
        {
            return @"队员";
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 102) {
        return 48 * self.view.scale;
    }
    return 0;
}
#pragma  mark- scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-offset);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@(227 *self.view.scale));
    }];
}
#pragma mark- getter
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.frame =self.view.frame;
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 5 TabHeight:40 VerticalDistance:10 BkColor:[UIColor whiteColor]];

        [_pageView addTab:@"留言" View:self.messageTableview Info:nil];
        [_pageView addTab:@"新闻" View:self.newsTableview Info:nil];
        [_pageView addTab:@"名单" View:self.listTableview Info:nil];
        [_pageView addTab:@"赛程" View:self.scheduleTableview Info:nil];
        [_pageView addTab:@"资料" View:self.infoTableview Info:nil];
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
- (UITableView*)messageTableview
{
    if (!_messageTableview) {
        _messageTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _messageTableview.delegate = self;
        _messageTableview.dataSource = self;
        _messageTableview.tag = 100;
        _messageTableview.contentSize = CGSizeMake(self.view.width, 2 * self.view.height);
        [_messageTableview registerClass:[MessageTableviewCell class] forCellReuseIdentifier:@"messageTableviewCell"];
    }
    return _messageTableview;
}
- (UITableView*)newsTableview
{
    if (!_newsTableview) {
        _newsTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _newsTableview.delegate = self;
        _newsTableview.dataSource = self;
        _newsTableview.tag = 101;
        [_newsTableview registerClass:[TeamNewsCell class] forCellReuseIdentifier:@"TeamNewsCell"];
    }
    return _newsTableview;
}
- (UITableView*)listTableview
{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableview.delegate = self;
        _listTableview.dataSource = self;
        _listTableview.tag = 102;
        
        //        [_newsTableview registerClass:[MessageTableviewCell class] forCellReuseIdentifier:@"_messageTableviewCell"];
    }
    return _listTableview;
}
- (UITableView*)scheduleTableview
{
    if (!_scheduleTableview) {
        _scheduleTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scheduleTableview.delegate = self;
        _scheduleTableview.dataSource = self;
        _scheduleTableview.tag = 103;
        //        [_newsTableview registerClass:[MessageTableviewCell class] forCellReuseIdentifier:@"_messageTableviewCell"];
    }
    return _scheduleTableview;
}
- (UITableView*)infoTableview
{
    if (!_infoTableview) {
        _infoTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _infoTableview.delegate = self;
        _infoTableview.dataSource = self;
        _infoTableview.tag = 104;
        //        [_newsTableview registerClass:[MessageTableviewCell class] forCellReuseIdentifier:@"_messageTableviewCell"];
    }
    return _infoTableview;
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
#pragma mark -LazyPageScrollViewDelegate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 1) {
        [self.newsTableview reloadData];
    }
    else if (index == 2)
    {
        [self.listTableview reloadData];
    }
}

@end
