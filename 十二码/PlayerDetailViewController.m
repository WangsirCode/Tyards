//
//  PlayerDetailViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "MDABizManager.h"
#import "PlayerDetailViewModel.h"
#import "SEMTeamViewController.h"
#import "SEMTeamViewModel.h"
#import "NoticeCellView.h"
#import "GameListView.h"
#import "TeamLisstResponseModel.h"
#import "SEMTeamHomeViewController.h"
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
#import "PlayerInfoView.h"
#import "InfoViewCell.h"
#import "SEMNewsDetailController.h"
#import "MLImagePickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLImagePickerMenuTableViewCell.h"
#import "CommentBottomView.h"
#import "PictureShowView.h"
#import "SEMLoginViewController.h"
#define INFOTABLEVIEWTAG 100
#define NEWSTABLEVIEWTAG 101
#define MESSAGETABLEVIEWTAG 102
@interface PlayerDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,ShareViewDelegate,UITextFieldDelegate,NewsCommentCellDelegate>
@property (nonatomic,strong) PlayerDetailViewModel *viewModel;
@property (nonatomic,strong) UIImageView        * logoImageView;
@property (nonatomic,strong) LazyPageScrollView * pageView;
@property (nonatomic,strong) UITableView        * messageTableview;
@property (nonatomic,strong) UITableView        * newsTableview;
@property (nonatomic,strong) MBProgressHUD      * hud;
//@property (nonatomic,strong) UIBarButtonItem    * shareItem;
@property (nonatomic,strong) UIBarButtonItem    * favoriteItem;
@property (nonatomic,strong) UIBarButtonItem    * blankItem;
@property (nonatomic,strong) ShareView          * shareView;
@property (nonatomic,strong) UIView             * maskView;
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) UITableView        *infoTableView;
@property (nonatomic,strong) UIButton           * likeButton;
@property (nonatomic,strong) CommentBottomView  * bottomView;
@property (nonatomic,strong) PictureShowView    * pictureShowView;
@end

@implementation PlayerDetailViewController
#pragma mark- lifeCycle
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[PlayerDetailViewModel alloc] initWithDictionary:dictionary];
    }
    return self;
}
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
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItems = @[self.favoriteItem];
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
    [RACObserve(self.viewModel, status) subscribeNext:^(id x) {
        if (self.viewModel.status == 3) {
            [self.hud hide:YES];
            self.navigationItem.title = self.viewModel.model.player.name;
            NSString* urlstring = self.viewModel.model.player.avatar.url;
            if (urlstring) {
                NSString* encodedString = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [[NSURL alloc] initWithString:encodedString];
                [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
            }
            else
            {
                self.logoImageView.image = [UIImage placeholderImage];
            }
            [self.messageTableview reloadData];
            [self.infoTableView reloadData];
        }
    }];
    [RACObserve(self.viewModel, shouldReloadCommentTable) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadCommentTable == YES) {
            [self.messageTableview reloadData];
            [self.pictureShowView removeFromSuperview];
            self.viewModel.images = nil;
            [self.bottomView reSetView];
            [self.bottomView removeFromSuperview];
            [self.view addSubview:self.bottomView];
            self.bottomView.sd_resetLayout
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .bottomEqualToView(self.view)
            .heightIs(50*self.view.scale);
            self.bottomView.textField.placeholder = @"说点什么吧";
            self.bottomView.textField.text = nil;
            [XHToast showCenterWithText:@"发表成功" duration:1];
            self.viewModel.postType = 1;
            self.bottomView.sendButton.enabled = NO;
            self.viewModel.content = nil;
        }
    }];
    [[self.bottomView.textField rac_textSignal] subscribeNext:^(NSString* x) {
        if (x.length > 0) {
            self.bottomView.sendButton.enabled = YES;
            self.viewModel.content = x;
        }
        else
        {
            self.bottomView.sendButton.enabled = NO;
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
    [RACObserve(self.viewModel, updateNewsTable) subscribeNext:^(id x) {
        if (self.viewModel.updateNewsTable == YES) {
            [self.newsTableview.mj_footer endRefreshing];
            [self.newsTableview reloadData];
        }
    }];
    [RACObserve(self.viewModel, updateCommentTable) subscribeNext:^(id x) {
        if (self.viewModel.updateCommentTable == YES) {
            [self.messageTableview.mj_footer endRefreshing];
            [self.messageTableview reloadData];
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
#pragma mark - bottomCommentViewset
- (void)setTapGesture
{
    [[_bottomView.imageButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self addPhoto];
    }];
    [[_bottomView.sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.bottomView.textField resignFirstResponder];
        if ([self.viewModel didLogined]) {
             self.bottomView.sendButton.enabled = NO;
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
                      self.bottomView.sendButton.enabled = YES;
                      
                      self.pictureShowView = [[PictureShowView alloc] initWithImages:self.viewModel.images];
                      [self.view addSubview:self.pictureShowView];
                      self.pictureShowView.sd_layout
                      .leftEqualToView(self.view)
                      .rightEqualToView(self.view)
                      .bottomEqualToView(self.view);
                      self.bottomView.sd_resetLayout
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
    if (tableView.tag == INFOTABLEVIEWTAG) {
        return 3;
    }
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        return self.viewModel.messageModel.count;
    }
    else if (tableView.tag == INFOTABLEVIEWTAG)
    {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return self.viewModel.palyerData.history.count;
                break;
            case 2:
                return self.viewModel.palyerData.honours.count;
                break;
            default:
                return 0;
                break;
        }
    }
    else
    {
        return self.viewModel.model.articles.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        NewsCommentCell* cell = [[NewsCommentCell alloc] init];
        cell.model = self.viewModel.messageModel[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
    else if (tableView.tag == NEWSTABLEVIEWTAG)
    {
        Articles* news = self.viewModel.model.articles[indexPath.row];
        TeamNewsCell* cell = (TeamNewsCell*)[tableView dequeueReusableCellWithIdentifier:@"TeamNewsCell"];
        cell.model = news;
        return cell;
    }
    else
    {
        if (indexPath.section == 0) {
            InfoViewCell* cell = (InfoViewCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoViewCell"];
            cell.model = self.viewModel.palyerData.data;
            return cell;
        }
        else if(indexPath.section == 1)
        {
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reamcell"];
            cell.textLabel.text = [self.viewModel.palyerData.history[indexPath.row] timeInfo];
            cell.detailTextLabel.text = [self.viewModel.palyerData.history[indexPath.row] teamInfo];
            cell.detailTextLabel.textColor = [UIColor MyColor];
            return cell;
        }
        else
        {
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"honorCell"];
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Copa del Rey"]];
            [cell addSubview:imageView];
            imageView.sd_layout.
            leftSpaceToView(cell,12*self.view.scale)
            .centerYEqualToView(cell)
            .heightIs(23*self.view.scale);
            cell.textLabel.text = [self.viewModel.palyerData.honours[indexPath.row] honorInfo];
            cell.textLabel.sd_layout
            .leftSpaceToView(imageView,8)
            .rightEqualToView(cell);
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        CGFloat height = [tableView cellHeightForIndexPath:indexPath model:self.viewModel.messageModel[indexPath.row] keyPath:@"model" cellClass:[NewsCommentCell class]  contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return height;
    }
    else if(tableView.tag == NEWSTABLEVIEWTAG)
    {
        return 120 * self.view.scale;
    }
    else
    {
        if (indexPath.section == 0) {
            return [tableView cellHeightForIndexPath:indexPath model:self.viewModel.palyerData.data keyPath:@"model" cellClass:[InfoViewCell class] contentViewWidth:self.view.width];
        }
        else
        {
            return 48*self.view.scale;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == INFOTABLEVIEWTAG) {
        return 48*self.view.scale;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == INFOTABLEVIEWTAG)
    {
        UIView* view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        UILabel* label = [UILabel new];
        if (section == 0) {
            label.text = @"个人简介";
        }
        else if(section == 1)
        {
            label.text = @"效力/执教球队";
        }
        else
        {
            label.text = @"荣誉";
        }
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        label.font = [UIFont systemFontOfSize:16];
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
#pragma mark- tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == NEWSTABLEVIEWTAG) {
        NSInteger ide = self.viewModel.model.articles[indexPath.row].id;
        SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];

    }
}
#pragma mark - PostComment
- (void)didClickComment:(NSInteger)newsId targetName:(NSString *)targetName
{
    self.viewModel.newsId = newsId;
    self.viewModel.postType = 2;
    self.bottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",targetName];
    self.bottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.bottomView.textField becomeFirstResponder];
}
- (void)didReplyComment:(NSInteger)newsId targetId:(NSInteger)targetId remindId:(NSInteger)remindID name:(NSString *)name
{
    self.viewModel.newsId = newsId;
    self.viewModel.postType = 3;
    self.bottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",name];
    self.bottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.bottomView.textField becomeFirstResponder];
    self.viewModel.remindId = remindID;
    self.viewModel.targetCommentId = targetId;
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
            [_pageView initTab:YES Gap:self.view.width / 3 TabHeight:40*self.view.scale VerticalDistance:0 BkColor:[UIColor whiteColor]];
            [_pageView addTab:@"资料" View:self.infoTableView Info:nil];
            [_pageView addTab:@"新闻" View:self.newsTableview Info:nil];
            [_pageView addTab:@"留言" View:self.messageTableview Info:nil];
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
- (UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.tag = INFOTABLEVIEWTAG;
        _infoTableView.contentSize = CGSizeMake(self.view.width, 2 * self.view.height);
        [_infoTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"InfoViewCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _infoTableView.tableHeaderView = backView;
        _infoTableView.bounces = NO;
        
    }
    return _infoTableView;
}
- (UITableView*)messageTableview
{
    if (!_messageTableview) {
        _messageTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _messageTableview.delegate = self;
        _messageTableview.dataSource = self;
        _messageTableview.tag = MESSAGETABLEVIEWTAG;
        _messageTableview.contentSize = CGSizeMake(self.view.width, 2 * self.view.height);
        [_messageTableview registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _messageTableview.tableHeaderView = backView;
        _messageTableview.backgroundColor = [UIColor BackGroundColor];
        _messageTableview.separatorColor = [UIColor BackGroundColor];
        _messageTableview.bounces =NO;
        _messageTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreComment];
        }];
    }
    return _messageTableview;
}
- (UITableView*)newsTableview
{
    if (!_newsTableview) {
        _newsTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _newsTableview.delegate = self;
        _newsTableview.dataSource = self;
        _newsTableview.tag = NEWSTABLEVIEWTAG;
        [_newsTableview registerClass:[TeamNewsCell class] forCellReuseIdentifier:@"TeamNewsCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _newsTableview.tableHeaderView = backView;
        _newsTableview.backgroundColor = [UIColor BackGroundColor];
        _newsTableview.separatorColor = [UIColor BackGroundColor];
        _newsTableview.bounces = NO;
        _newsTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreNews];
        }];
    }
    return _newsTableview;
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
        button.frame     = CGRectMake(0, 0, 20, 15);
        _backItem        = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backItem;
}
- (CommentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [CommentBottomView new];
        _bottomView.textField.delegate = self;
        //        _bottomView.userInteractionEnabled = YES;
        _bottomView.backgroundColor = [UIColor BackGroundColor];
        [self setTapGesture];
    }
    return _bottomView;
}
#pragma mark -LazyPageScrollViewDelegate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 1) {
        [self.bottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        [self.newsTableview reloadData];
    }
    else if (index == 0)
    {
        [self.bottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        [self.infoTableView reloadData];
    }
    else if (index == 2)
    {
        [self.view addSubview:self.bottomView];
        self.bottomView.sd_layout
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
        [self.messageTableview reloadData];
    }
}

@end


