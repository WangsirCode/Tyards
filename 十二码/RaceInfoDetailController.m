//
//  RaceInfoDetailController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "RaceInfoDetailController.h"

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
#import "RaceInfoViewModel.h"
#import "PlayHistory.h"
#import "HistoryView.h"
#import "CommentBottomView.h"
#import "CenterAlertIView.h"
#import "MLImagePickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLImagePickerMenuTableViewCell.h"
#import "PictureShowView.h"
#import "SEMLoginViewController.h"
#import "SEMTeamHomeViewController.h"
@interface RaceInfoDetailController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,ShareViewDelegate,UITextFieldDelegate,NewsCommentCellDelegate>
@property (nonatomic,strong) RaceInfoViewModel  * viewModel;
@property (nonatomic,strong) NoticeCellView        * headerView;
@property (nonatomic,strong) UIImageView* backImageView;
@property (nonatomic,strong) LazyPageScrollView * pageView;
@property (nonatomic,strong) UITableView        * newsTableView;
@property (nonatomic,strong) UIScrollView       * statusView;
@property (nonatomic,strong) UIScrollView       * dataView;
@property (nonatomic,strong) UITableView        * messageTableView;
@property (nonatomic,strong) UIView             * bottomView;
@property (nonatomic,strong) MBProgressHUD      * hud;
@property (nonatomic,strong) UIBarButtonItem    * blankItem;
@property (nonatomic,strong) ShareView          * shareView;
@property (nonatomic,strong) UIView             * maskView;
@property (nonatomic,strong) UIBarButtonItem    * backItem;
@property (nonatomic,strong) CommentBottomView  * commmentBottomView;
@property (nonatomic,strong) PictureShowView    * pictureShowView;
@end

@implementation RaceInfoDetailController
- (instancetype)initWithDictionay:(NSDictionary *)dictionary
{
    self = [super initWithDictionay:dictionary];
    if (self) {
        self.viewModel = [[RaceInfoViewModel alloc] initWithDictionary:dictionary];
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
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.pageView];
//    self.navigationItem.rightBarButtonItems = @[self.shareItem,self.blankItem];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.hud.labelText = @"加载中";
}

- (void)makeConstraits
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@(227 *self.view.scale));
    }];
    [self.backImageView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView).offset(60*self.view.scale);
        make.left.and.right.equalTo(self.backImageView);
        make.bottom.equalTo(self.backImageView.mas_bottom);
    }];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
- (void)bindModel
{
    //当加载完毕之后隐藏hud
    [RACObserve(self.viewModel, status) subscribeNext:^(id x) {
        if (self.viewModel.status == 5) {
            [self.hud hide:YES];
            self.navigationItem.title = self.viewModel.gameModel.tournament.name;
            [self setUpHeaderView];
            [self setUpDataView];
            [self setUpstatusView];
            [self.newsTableView reloadData];
            [self.messageTableView reloadData];
        }
    }];
    [RACObserve(self.viewModel, shouldReloadCommentTable) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadCommentTable == YES) {
            [self.messageTableView reloadData];
            [self.pictureShowView removeFromSuperview];
            self.viewModel.images = nil;
            [self.commmentBottomView reSetView];
            [self.commmentBottomView removeFromSuperview];
            [self.view addSubview:self.commmentBottomView];
            self.commmentBottomView.sd_resetLayout
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .bottomEqualToView(self.view)
            .heightIs(50*self.view.scale);
            self.commmentBottomView.textField.placeholder = @"说点什么吧";
            self.commmentBottomView.textField.text = nil;
            self.viewModel.postType = 1;
            [XHToast showCenterWithText:@"发表成功" duration:1];
            self.commmentBottomView.sendButton.enabled = NO;
            self.viewModel.content = nil;
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
    [RACObserve(self.backImageView, frame) subscribeNext:^(id x) {
        if (self.pageView.frame.origin.y < -44) {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
        }
    }];
    [[self.commmentBottomView.textField rac_textSignal] subscribeNext:^(NSString* x) {
        if (x.length > 0) {
            self.commmentBottomView.sendButton.enabled = YES;
            self.viewModel.content = x;
        }
        else
        {
            self.commmentBottomView.sendButton.enabled = NO;
        }
    }];
    [RACObserve(self.viewModel, updateMessagaTable) subscribeNext:^(id x) {
        if (self.viewModel.updateMessagaTable == YES) {
            [self.messageTableView.mj_footer endRefreshing];
            [self.messageTableView reloadData];
        }
    }];
    [RACObserve(self.viewModel, updateNewsTable) subscribeNext:^(id x) {
        if (self.viewModel.updateNewsTable == YES) {
            [self.newsTableView.mj_footer endRefreshing];
            [self.newsTableView reloadData];
        }
    }];
}
- (void)setUpHeaderView
{
    Games* model = self.viewModel.gameModel;
    self.headerView.titleLabel.text = @"";
    NSMutableString* info = [NSMutableString new];
    if (model.group.name) {
        [info appendString:model.group.name];
        [info appendString:@"  "];
    }
    if (model.round.name) {
        [info appendString:model.round.name];
    }
    self.headerView.roundLabel.text = info;
    self.headerView.status = [model getStatus1];
    if (self.headerView.status == 2) {
        self.headerView.homeScoreLabel.text = @"-";
        self.headerView.awaySocreLabel.text = @"-";
    }
    else
    {
        if (model.penaltyAway == 0 && model.penaltyHome == 0) {
            self.headerView.homeScoreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.homeScore];
            self.headerView.awaySocreLabel.text = [NSString stringWithFormat: @"%ld", (long)model.awayScore];
        }
        else
        {
            self.headerView.homeScoreLabel.text = [NSString stringWithFormat: @"%ld(%ld)", (long)model.homeScore,(long)model.penaltyHome];
            self.headerView.awaySocreLabel.text = [NSString stringWithFormat: @"(%ld)%ld", (long)model.penaltyAway,(long)model.awayScore];
        }
    }
    self.headerView.centerLabel.textColor = [UIColor whiteColor];
    self.headerView.homeScoreLabel.textColor = [UIColor whiteColor];
    self.headerView.awaySocreLabel.textColor = [UIColor whiteColor];
    self.headerView.homeTitleLabel.textColor = [UIColor whiteColor];
    self.headerView.awayTitleLabel.textColor = [UIColor whiteColor];
    self.headerView.homeTitleLabel.text = model.home.name;
    self.headerView.awayTitleLabel.text = model.away.name;
    self.headerView.homeLabel.text = model.stadium.name;
    UIImage *image = [UIImage imageNamed:@"zhanwei.jpg"];
    NSURL *homeurl;
    if (model.home.logo.url) {
        homeurl = [[NSURL alloc] initWithString:model.home.logo.url];
        [self.headerView.homeImageview sd_setImageWithURL:homeurl placeholderImage:image options:SDWebImageRefreshCached];
    }
    else
    {
        self.headerView.homeImageview.image = image;
    }
    self.headerView.userInteractionEnabled = YES;
    self.headerView.homeImageview.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        SEMTeamHomeViewController* controller = [[SEMTeamHomeViewController alloc] initWithDictionary:@{@"ide":@(model.home.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [self.headerView.homeImageview addGestureRecognizer:tap];
    NSURL *awayurl;
    if (model.away.logo.url) {
        awayurl = [[NSURL alloc] initWithString:model.away.logo.url];
        [self.headerView.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
    }
    else
    {
        self.headerView.awayImgaeview.image = image;
    }
    self.headerView.awayImgaeview.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        SEMTeamHomeViewController* controller = [[SEMTeamHomeViewController alloc] initWithDictionary:@{@"ide":@(model.away.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [self.headerView.awayImgaeview addGestureRecognizer:tap1];
    self.headerView.location = 1;
    self.headerView.timeLabel.text = [model getDate2];
    self.headerView.roundLabel.textColor = [UIColor colorWithHexString:@"#6B7CA0"];
    self.headerView.timeLabel.textColor = [UIColor colorWithHexString:@"#6B7CA0"];
    self.headerView.homeLabel.textColor =[UIColor colorWithHexString:@"#6B7CA0"];
    [self.headerView.locationImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10*self.view.scale));
        make.width.equalTo(@(7*self.view.scale));
        make.top.equalTo(self.headerView.homeTitleLabel.mas_bottom).offset(15*self.view.scale);
        make.left.equalTo(self.headerView.mas_left).offset(8*self.view.scale);
    }];
}
- (void)setUpDataView
{
    UIView* view = [UIView new];
    view.frame = CGRectMake(0, 0, self.view.width, 8);
    view.backgroundColor = [UIColor BackGroundColor];
    [self.dataView addSubview:view];
    
    UILabel* fisrtLabel = [UILabel new];
    fisrtLabel.text = @"球队战绩";
    fisrtLabel.textColor = [UIColor MyColor];
    fisrtLabel.font = [UIFont systemFontOfSize:16*self.view.scale];
    [self.dataView addSubview:fisrtLabel];
    fisrtLabel.sd_layout
    .topSpaceToView(view,0)
    .leftSpaceToView(self.dataView,12)
    .rightEqualToView(self.dataView)
    .heightIs(44*self.view.scale);
    
    DataView* homeData = [[DataView alloc] init];
    homeData.titleLabel.text = self.viewModel.dataModel.homeData.team.name;
    homeData.numLabel.text = [@([self.viewModel.dataModel.homeData getNum]) stringValue];
    homeData.winLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.homeData.wins];
    homeData.loseLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.homeData.loses];
    homeData.drawLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.homeData.draws];
    [self.dataView addSubview:homeData];
    homeData.sd_layout.topSpaceToView(fisrtLabel,12)
    .leftSpaceToView(self.dataView,12)
    .rightSpaceToView(self.dataView,12)
    .heightIs(144*self.view.scale);
    
    DataView* awayData = [[DataView alloc] init];
    awayData.titleLabel.text = self.viewModel.dataModel.awayData.team.name;
    awayData.numLabel.text = [@([self.viewModel.dataModel.awayData getNum]) stringValue];
    awayData.winLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.awayData.wins];
    awayData.loseLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.awayData.loses];
    awayData.drawLabel.text = [NSString stringWithFormat:@"%ld",self.viewModel.dataModel.awayData.draws];
    [self.dataView addSubview:awayData];
    awayData.sd_layout.topSpaceToView(homeData,16)
    .leftSpaceToView(self.dataView,12)
    .rightSpaceToView(self.dataView,12)
    .heightIs(144*self.view.scale);
    
    UILabel* secLabel = [UILabel new];
    secLabel.text = @"历史交锋";
    secLabel.textColor = [UIColor MyColor];
    secLabel.font = [UIFont systemFontOfSize:16*self.view.scale];
    [self.dataView addSubview:secLabel];
    secLabel.sd_layout
    .topSpaceToView(awayData,12)
    .leftSpaceToView(self.dataView,12)
    .rightEqualToView(self.dataView)
    .heightIs(44*self.view.scale);
    
    HistoryView* histoty = [[HistoryView alloc] init];
    histoty.layer.borderColor = [UIColor BackGroundColor].CGColor;
    histoty.layer.borderWidth = 1;
    histoty.history = self.viewModel.dataModel.history;
    [self.dataView addSubview:histoty];
    histoty.sd_layout
    .topSpaceToView(secLabel,12)
    .leftSpaceToView(self.dataView,12)
    .rightSpaceToView(self.dataView,12)
    .heightIs(120*(self.viewModel.dataModel.history.count)*self.view.scale);
    
    [self.dataView setupAutoContentSizeWithBottomView:histoty bottomMargin:20];
    
}
- (void)setUpstatusView
{
    UIView* backView = [UIView new];
    backView.backgroundColor = [UIColor BackGroundColor];
    [self.statusView addSubview:backView];
    backView.sd_layout
    .topEqualToView(self.statusView)
    .leftEqualToView(self.statusView)
    .rightEqualToView(self.statusView)
    .heightIs(8);
    NSDictionary* imageDic = @{@"GOAL":@"约战-进球",@"YELLOWCARD":@"约战-黄",@"REDCARD":@"约战-红",@"OWNGOAL":@"约战-乌龙",@"ASSIST":@"约战-助攻"};
    for (int i = 0; i < self.viewModel.eventModel.events.count + 1; i++) {
        UIView* line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"CACACA"];
        UILabel* label = [UILabel new];
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.font = [UIFont systemFontOfSize:14*self.view.scale];
        UIImageView* imageView = [UIImageView new];
        [self.statusView sd_addSubviews:@[line,label,imageView]];
        imageView.sd_layout
        .topSpaceToView(backView,50*i*self.view.scale + 8)
        .centerXEqualToView(self.statusView)
        .heightIs(14*self.view.scale)
        .widthIs(14*self.view.scale);
        line.sd_layout
        .topSpaceToView(imageView,8*self.view.scale)
        .centerXEqualToView(self.statusView)
        .heightIs(20*self.view.scale)
        .widthIs(1);
        Events* model;
        if (i!= 0) {
            model = self.viewModel.eventModel.events[i-1];
            imageView.image = [UIImage imageNamed:imageDic[model.type]];
            label.text = model.player.name;
            if (model.home) {
                label.textAlignment = NSTextAlignmentRight;
                label.sd_layout
                .topSpaceToView(backView,50*self.view.scale*i + 8)
                .rightSpaceToView(imageView,12*self.view.scale)
                .heightIs(14*self.view.scale)
                .widthIs(100);
                
            }
            else
            {
                label.textAlignment = NSTextAlignmentLeft;
                label.sd_layout
                .topSpaceToView(backView,50*self.view.scale*i + 8)
                .leftSpaceToView(imageView,12*self.view.scale)
                .heightIs(14*self.view.scale)
                .widthIs(100);
            }
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"约战-时间"];
        }
        if (i == self.viewModel.eventModel.events.count) {
            line.hidden = YES;
            [self.statusView setupAutoContentSizeWithBottomView:imageView bottomMargin:100*self.view.scale];
        }
    }
    self.bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor BackGroundColor];
    NSArray* imageName = @[@"约战-进球",@"约战-乌龙",@"约战-黄",@"约战-红",@"约战-助攻"];
    NSArray* names = @[@"进球",@"乌龙",@"黄牌",@"红牌",@"助攻"];
    for (int i = 0; i < 5 ; i ++) {
        UIImageView* imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:imageName[i]];
        UILabel* label = [UILabel new];
        label.text = names[i];
        label.font = [UIFont systemFontOfSize:13*self.view.scale];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        [_bottomView sd_addSubviews:@[imageView,label]];
        imageView.sd_layout
        .centerYEqualToView(_bottomView)
        .leftSpaceToView(_bottomView,self.view.scale*(10+i*73))
        .heightIs(14*self.view.scale)
        .widthIs(14*self.view.scale);
        label.sd_layout
        .leftSpaceToView(imageView,8*self.view.scale)
        .centerYEqualToView(_bottomView)
        .heightIs(20)
        .widthIs(40);
    }
    [self.view addSubview:_bottomView];
    _bottomView.sd_layout
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(58*self.view.scale);
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
#pragma mark - bottomCommentViewset
- (void)setTapGesture
{
    [[_commmentBottomView.imageButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self addPhoto];
    }];
    [[_commmentBottomView.sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.commmentBottomView.textField resignFirstResponder];
        if ([self.viewModel didLogined]) {
            self.commmentBottomView.sendButton.enabled = NO;
            [self.viewModel addNews];
        }
        else
        {
            SEMLoginViewController* login = [HRTRouter objectForURL:@"login" withUserInfo:@{}];
            [self presentViewController:login animated:YES completion:nil];
        }
    }];
}
- (void)addPhoto
{
    MLImagePickerViewController *pickerVC = [MLImagePickerViewController pickerViewController];
    // Limit Count
    [pickerVC.navigationController.navigationBar setBackgroundColor:[UIColor MyColor]];
    pickerVC.maxCount = 9 - self.viewModel.images.count;
    pickerVC.assetsFilter = MLImagePickerAssetsFilterAllPhotos;
    // Recoder
    WeakSelf
    [pickerVC displayForVC:self
          completionHandle:^(BOOL success,
                             NSArray<NSURL *> *assetUrls,
                             NSArray<UIImage *> *thumbImages,
                             NSArray<UIImage *> *originalImages,
                             NSError *error) {
              if (success) {
                  if (thumbImages.count > 0) {
                      if (self.viewModel.images) {
                          NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewModel.images];
                          [array appendObjects:thumbImages];
                          self.viewModel.images = nil;
                          self.viewModel.images = array;
                      }
                      else
                      {
                          self.viewModel.images = thumbImages;
                      }
                      self.commmentBottomView.sendButton.enabled = YES;
                      
                      self.pictureShowView = [[PictureShowView alloc] initWithImages:self.viewModel.images];
                      [self.view addSubview:self.pictureShowView];
                      self.pictureShowView.sd_layout
                      .leftEqualToView(self.view)
                      .rightEqualToView(self.view)
                      .bottomEqualToView(self.view);
                      self.commmentBottomView.sd_resetLayout
                      .bottomSpaceToView(self.view,self.view.scale*60*(self.viewModel.images.count / 5 + 1) + 10 * self.view.scale)
                      .leftEqualToView(self.view)
                      .rightEqualToView(self.view)
                      .heightIs(50*self.view.scale);
                      if (self.viewModel.images.count < 9) {
                          UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                              [self addPhoto];
                          }];
                          [self.pictureShowView.addImageView addGestureRecognizer:tap];
                      }
                  }
              }
          }];
    
}
#pragma mark - PostComment
- (void)didClickComment:(NSInteger)newsId targetName:(NSString *)targetName
{
    self.viewModel.newsId = newsId;
    self.viewModel.postType = 2;
    self.commmentBottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",targetName];
    self.commmentBottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.commmentBottomView.textField becomeFirstResponder];
}
- (void)didReplyComment:(NSInteger)newsId targetId:(NSInteger)targetId remindId:(NSInteger)remindID name:(NSString *)name
{
    self.viewModel.newsId = newsId;
    self.viewModel.postType = 3;
    self.commmentBottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",name];
    self.commmentBottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.commmentBottomView.textField becomeFirstResponder];
    self.viewModel.remindId = remindID;
    self.viewModel.targetCommentId = targetId;
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
    if (tableView.tag == 102)
    {
        return self.viewModel.newsModel.count;
    }
    else if (tableView.tag == 101)
    {
        return 0;
    }
    else if(tableView.tag == 103)
    {
        return self.viewModel.messageModel.count;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 102) {
        News* news = self.viewModel.newsModel[indexPath.row];
        HomeCell* cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
        cell.model = news;
        return cell;
    }
    else if (tableView.tag == 103)
    {
        NewsCommentCell* cell = [[NewsCommentCell alloc] init];
        cell.model = self.viewModel.messageModel[indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 102)
    {
        return 120*self.view.scale;
    }
    else if (tableView.tag == 103)
    {
        CGFloat height = [tableView cellHeightForIndexPath:indexPath model:self.viewModel.messageModel[indexPath.row] keyPath:@"model" cellClass:[NewsCommentCell class]  contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return height;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 102) {
        NSInteger ide = self.viewModel.newsModel[indexPath.row].id;
        SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma  mark- scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < 175) {
        [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
        [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
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
        [_pageView initTab:YES Gap:self.view.width / 4 TabHeight:40*self.view.scale VerticalDistance:0 BkColor:[UIColor whiteColor]];
        [_pageView addTab:@"赛况" View:self.statusView Info:nil];
        [_pageView addTab:@"数据" View:self.dataView Info:nil];
        [_pageView addTab:@"新闻" View:self.newsTableView Info:nil];
        [_pageView addTab:@"互动" View:self.messageTableView Info:nil];
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
- (UITableView*)newsTableView
{
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
        _newsTableView.tag = 102;
        [_newsTableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _newsTableView.tableHeaderView = backView;
        _newsTableView.backgroundColor = [UIColor BackGroundColor];
        _newsTableView.separatorColor = [UIColor BackGroundColor];
        _newsTableView.bounces = NO;
        _newsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreNews];
        }];
    }
    return _newsTableView;
}
- (UIScrollView *)statusView
{
    if (!_statusView) {
        _statusView = [UIScrollView new];
        _statusView.delegate = self;
        _statusView.bounces = NO;
    }
    return _statusView;
}
- (UIScrollView *)dataView
{
    if (!_dataView) {
        _dataView = [UIScrollView new];
        _dataView.delegate = self;
        _dataView.bounces = NO;
    }
    return _dataView;
}

- (UITableView*)messageTableView
{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.tag = 103;
        [_messageTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _messageTableView.tableHeaderView = backView;
        _messageTableView.backgroundColor = [UIColor BackGroundColor];
        _messageTableView.separatorColor = [UIColor BackGroundColor];
        _messageTableView.bounces = NO;
        _messageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreMessages];
        }];

    }
    return _messageTableView;
}

- (NoticeCellView*)headerView
{
    if (!_headerView) {
        _headerView = [[NoticeCellView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
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
//-(UIBarButtonItem *)shareItem
//{
//    if (!_shareItem) {
//        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, 20, 25);
//        
//        [button setImage:[UIImage imageNamed:@"upload_L"] forState:UIControlStateNormal];
//        _shareItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        button.rac_command = self.viewModel.shareCommand;
//    }
//    return _shareItem;
//}
- (UIBarButtonItem *)blankItem
{
    if (!_blankItem) {
        _blankItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        _blankItem.width = 20;
    }
    return _blankItem;
}
- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"深色背景"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}
- (CommentBottomView *)commmentBottomView
{
    if (!_commmentBottomView) {
        _commmentBottomView = [CommentBottomView new];
        _commmentBottomView.textField.delegate = self;
        //        _bottomView.userInteractionEnabled = YES;
        _commmentBottomView.backgroundColor = [UIColor BackGroundColor];
        [self setTapGesture];
    }
    return _commmentBottomView;
}
#pragma mark -LazyPageScrollViewDelegate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 0) {
        [self.commmentBottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        self.bottomView.hidden = NO;
    }
    else if (index == 1)
    {
        [self.commmentBottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        self.bottomView.hidden = YES;
    }
    else if (index == 2)
    {
        [self.commmentBottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        self.bottomView.hidden = YES;
        [self.newsTableView reloadData];
    }
    else if (index == 3)
    {
        [self.view addSubview:self.commmentBottomView];
        self.commmentBottomView.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view)
        .heightIs(50*self.view.scale);
        if (self.viewModel.images.count > 0) {
            [self.view addSubview:self.pictureShowView];
            self.pictureShowView.sd_layout
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .bottomEqualToView(self.view);
        }
        [self.messageTableView reloadData];
    }
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

@end
