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
@interface GameInfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,ShareViewDelegate,ListTableHeaderVIewDelegate>
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
@property (nonatomic,strong) ListTableHeaderVIew* listTableHeaderView;
@property (nonatomic,strong) UIButton           * likeButton;
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
        if (self.viewModel.status == 6) {
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
            self.listTableHeaderView.scoreButton.selected = YES;
            self.listTableHeaderView.scoreButton.layer.borderColor = [UIColor MyColor].CGColor;
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
    [RACObserve(self.viewModel,fan) subscribeNext:^(id x) {
        self.likeButton.selected = self.viewModel.fan;
        if (self.viewModel.didFaned) {
            if (self.viewModel.fan) {
                [XHToast showCenterWithText:@"关注成功"];
            }
            else
            {
                [XHToast showCenterWithText:@"取消关注成功"];
            }
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
        if (self.viewModel.listTableIndex == 0) {
            return self.viewModel.scoreModel.count;
        }
        return 1;
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
        if (self.viewModel.listTableIndex == 0) {
            return self.viewModel.scoreModel[section].grids.count;
        }
        else if (self.viewModel.listTableIndex == 1)
        {
            return self.viewModel.scorerModel.count;
        }
        else
        {
            return self.viewModel.awardModel.count;
        }
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
        if (model.away.logo.url) {
            awayurl = [[NSURL alloc] initWithString:model.away.logo.url];
            [cell.view.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
        }
        else
        {
            cell.view.awayImgaeview.image = image;
        }
        cell.view.location = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (model.latestNews) {
            [cell.button setTitle:model.latestNews.detail forState:UIControlStateNormal];
        }
        return cell;
    }
    else if (tableView.tag == 102)
    {
        if (self.viewModel.listTableIndex == 0) {
            Grids* model = self.viewModel.scoreModel[indexPath.section].grids[indexPath.row];
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"scroreCell"];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld.",(long)(indexPath.row + 1)];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor MyColor];
            cell.detailTextLabel.text = model.team.name;
            cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
            cell.detailTextLabel.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.textLabel,24*self.view.scale)
            .heightIs(cell.contentView.height)
            .maxWidthIs(140*self.view.scale);
            NSArray<NSNumber*>* array = @[@([model getNum]),@(model.wins),@(model.draws),@(model.loses),@(model.points)];
            for (int i = 0; i < 5; i++) {
                UILabel* label = [UILabel new];
                label.textColor = [UIColor blackColor];
                label.text = [array[i] stringValue];
                label.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:label];
                label.sd_layout
                .leftSpaceToView(cell.contentView,160*self.view.scale + i * 42 *self.view.scale)
                .centerYEqualToView(cell.contentView)
                .widthIs(35*self.view.scale)
                .heightIs(cell.contentView.height);
            }
            return cell;
        }
        else if (self.viewModel.listTableIndex == 1)
        {
            ScorerListModel* model = self.viewModel.scorerModel[indexPath.row];
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"scorerCell"];
            if (indexPath.row < 3) {
                UIImageView* imageView = [UIImageView new];
                [cell.contentView addSubview:imageView];
                imageView.sd_layout
                .centerYEqualToView(cell.contentView)
                .leftSpaceToView(cell.contentView,17*self.view.scale)
                .widthIs(17*self.view.scale)
                .heightIs(13.3*self.view.scale);
                switch (indexPath.row) {
                    case 0:
                        imageView.image = [UIImage imageNamed:@"scorer"];
                        break;
                    case 1:
                        imageView.image = [UIImage imageNamed:@"scorer2"];
                        break;
                    case 2:
                        imageView.image = [UIImage imageNamed:@"scorer3"];
                    default:
                        break;
                }
            }
            else
            {
                UILabel* label = [UILabel new];
                label.text = [NSString stringWithFormat:@"%ld.",(indexPath.row + 1)];
                [cell.contentView addSubview:label];
                label.sd_layout
                .leftSpaceToView(cell.contentView,17*self.view.scale)
                .centerYEqualToView(cell.contentView)
                .heightIs(cell.contentView.height)
                .widthIs(20);
            }
            cell.textLabel.text = model.player.name;
            cell.textLabel.textColor = [UIColor MyColor];
            cell.textLabel.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,70*self.view.scale)
            .heightIs(cell.contentView.height)
            .widthIs(85*self.view.scale);
            cell.detailTextLabel.textColor = [UIColor MyColor];
            cell.detailTextLabel.text = model.team.name;
            cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
            cell.detailTextLabel.sd_layout
            .leftSpaceToView(cell.contentView,165*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .heightIs(cell.contentView.height)
            .maxWidthIs(135*self.view.scale);
            
            UILabel* num = [UILabel new];
            [cell.contentView addSubview:num];
            num.textAlignment = NSTextAlignmentCenter;
            num.text = [NSString stringWithFormat:@"%ld",model.score];
            num.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,310*self.view.scale)
            .heightIs(cell.contentView.height)
            .widthIs(35*self.view.scale);
            return cell;
        }
        else
        {
            AwardListModel* model = self.viewModel.awardModel[indexPath.row];
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"awardCell"];
            if (model.logo.url) {
                NSURL* url = [[NSURL alloc] initWithString:model.logo.url];
                [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                cell.imageView.image = [UIImage placeholderImage];
            }
            cell.imageView.sd_cornerRadiusFromWidthRatio = @0.5;
            cell.imageView.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,10*self.view.scale)
            .heightIs(25*self.view.scale)
            .widthEqualToHeight();
            cell.textLabel.text = model.name;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.sd_layout
            .leftSpaceToView(cell.imageView,8)
            .centerYEqualToView(cell.contentView)
            .heightIs(cell.contentView.height)
            .widthIs(140*self.view.scale);
            cell.detailTextLabel.text = model.owner;
            cell.detailTextLabel.textColor = [UIColor MyColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.sd_layout
            .leftSpaceToView(cell.contentView,185*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .heightIs(cell.contentView.height)
            .widthIs(150);
            return cell;
        }
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
        if (self.viewModel.scheduleModel.latestsrounds[indexPath.row].games[indexPath.section].latestNews.detail) {
            return 181*self.view.scale;
        }
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
    else if (tableView.tag == 102)
    {
        return 48*self.view.scale;
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
    else if(tableView.tag == 102)
    {
        return 48*self.view.scale;
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
    else if (tableView.tag == 102)
    {
        if (self.viewModel.listTableIndex == 0) {
            UIView* view = [UIView new];
            UILabel* label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = self.viewModel.scoreModel[section].name;
            [view addSubview:label];
            label.sd_layout
            .centerYEqualToView(view)
            .leftSpaceToView(view,12*self.view.scale)
            .heightIs(48*self.view.scale)
            .maxWidthIs(170*self.view.scale);
            NSArray<NSString*> *array = @[@"场次",@"胜",@"平",@"负",@"积分"];
            for (int i = 0; i < 5; i ++) {
                UILabel* label = [UILabel new];
                label.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
                label.text = array[i];
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
                label.sd_layout
                .leftSpaceToView(view,160*self.view.scale + i * 42 *self.view.scale)
                .centerYEqualToView(view)
                .widthIs(35*self.view.scale)
                .heightIs(48*self.view.scale);
            }
            view.backgroundColor = [UIColor whiteColor];
            return view;
        }
        else if (self.viewModel.listTableIndex == 1)
        {
            UIView* view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            NSArray<NSNumber*>* array = @[@12,@70,@165,@295];
            NSArray<NSString*>* stringArray = @[@"排名",@"球员",@"所属球队",@"进球数"];
            for (int i = 0; i < 4 ; i ++) {
                UILabel *label = [UILabel new];
                label.text = stringArray[i];
                label.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
                if (i == 3) {
                    label.textAlignment = NSTextAlignmentCenter;
                }
                [view addSubview:label];
                label.sd_layout
                .leftSpaceToView(view,[array[i] integerValue]*self.view.scale)
                .centerYEqualToView(view)
                .heightIs(48*self.view.scale)
                .widthIs(70);
            }
            view.layer.borderColor = [UIColor BackGroundColor].CGColor;
            view.layer.borderWidth = 1;
            return view;
        }
        else
        {
            UIView* view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.borderWidth = 1;
            view.layer.borderColor = [UIColor BackGroundColor].CGColor;
            UILabel* label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
            label.text = @"奖项名称";
            UILabel* label2 = [UILabel new];
            label2.text = @"球队/球员/教练";
            label2.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
            [view sd_addSubviews:@[label2,label]];
            label.sd_layout
            .leftSpaceToView(view,12)
            .centerYEqualToView(view)
            .heightIs(48*self.view.scale)
            .widthIs(100);
            label2.sd_layout
            .leftSpaceToView(view,185*self.view.scale)
            .centerYEqualToView(view)
            .heightIs(48*self.view.scale)
            .widthIs(150);
            return view;
        }
        
    }
    return nil;
    
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        RaceInfoDetailController* controller = [[RaceInfoDetailController alloc] initWithDictionay:@{@"id":@(self.viewModel.scheduleModel.latestsrounds[indexPath.section].games[indexPath.row].id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }
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
        [_pageView initTab:YES Gap:self.view.width / 4 TabHeight:27 VerticalDistance:10 BkColor:[UIColor whiteColor]];
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
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _infoTableView.tableHeaderView = backView;
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
        _gameTableView.bounces = NO;
        _gameTableView.backgroundColor = [UIColor BackGroundColor];
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
        UIView* view = [UIView new];
        view.backgroundColor = [UIColor BackGroundColor];
        view.frame = CGRectMake(0, 0, self.view.width, self.view.scale * 68);
        [view addSubview:self.listTableHeaderView];
        self.listTableHeaderView.backgroundColor = [UIColor whiteColor];
        _listTableview.tableHeaderView = view;
        _listTableview.separatorInset = UIEdgeInsetsZero;
        _listTableview.bounces = NO;
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
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _teamTableView.tableHeaderView = backView;
        _teamTableView.backgroundColor = [UIColor BackGroundColor];
        _teamTableView.separatorColor = [UIColor BackGroundColor];
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
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(20, 0, 25, 25);
        [self.likeButton setImage:[UIImage imageNamed:@"icon_follow(1)"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"icon_followed(1)"] forState:UIControlStateSelected];
        _favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:self.likeButton];
        self.likeButton.rac_command = self.viewModel.likeCommand;
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
        button.frame = CGRectMake(0, 0, 20, 15);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
- (ListTableHeaderVIew *)listTableHeaderView
{
    if (!_listTableHeaderView) {
        _listTableHeaderView = [[ListTableHeaderVIew alloc] init];
        _listTableHeaderView.frame = CGRectMake(0, 0, self.view.width, self.view.scale * 60);
        _listTableHeaderView.layer.borderWidth = 1;
        _listTableHeaderView.layer.borderColor = [UIColor BackGroundColor].CGColor;
        _listTableHeaderView.delegate = self;
    
    }
    return _listTableHeaderView;
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
#pragma mark -HeaderViewDelagate
- (void)didClickButtonAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.listTableHeaderView.scorerButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.scorerButton.selected = NO;
            self.listTableHeaderView.awardButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.awardButton.selected = NO;
            if (self.viewModel.listTableIndex != 0) {
                self.viewModel.listTableIndex = 0;
                [self.listTableview reloadData];
            }
            break;
        case 1:
            self.listTableHeaderView.scoreButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.scoreButton.selected = NO;
            self.listTableHeaderView.awardButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.awardButton.selected = NO;
            if (self.viewModel.listTableIndex != 1) {
                self.viewModel.listTableIndex = 1;
                [self.listTableview reloadData];
            }
            break;
        case 2:
            self.listTableHeaderView.scoreButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.scoreButton.selected = NO;
            self.listTableHeaderView.scorerButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
            self.listTableHeaderView.scorerButton.selected = NO;
            if (self.viewModel.listTableIndex != 2) {
                self.viewModel.listTableIndex = 2;
                [self.listTableview reloadData];
            }
            break;
        default:
            break;
    }
}
@end

