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
#import "CommentCell.h"
#import "NoticeGameviewCell.h"
#import "CostomView.h"
#import "SEMTeamPhotoController.h"
#import "TeamDetailInfoView.h"
#import "PlayerDetailViewController.h"
#import "SEMNewsDetailController.h"
#import "CoachDetailViewController.h"
#import "CommentBottomView.h"
#import "CenterAlertIView.h"
#import "MLImagePickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLImagePickerMenuTableViewCell.h"
#import "PictureShowView.h"
#import "SEMLoginViewController.h"
#define LISTTABLEVIEWTAG 101
#define SCHEDULETABLEVIETAG 102
#define NEWSTABLEVIEWTAG 103
#define MESSAGETABLEVIEWTAG 104
#define RECORDINDEX 1
#define LISTINDEX 2
#define GAMESINDEX 3
@interface SEMTeamHomeViewController ()<UITableViewDelegate,UITableViewDataSource,LazyPageScrollViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CenterAlertIViewDelegate,NewsCommentCellDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) SEMTeamHomeModel   * viewModel;
@property (nonatomic,strong) UIImageView        * logoImageView;
@property (nonatomic,strong) LazyPageScrollView * pageView;
@property (nonatomic,strong) UITableView        * messageTableview;
@property (nonatomic,strong) UITableView        * newsTableview;
@property (nonatomic,strong) UITableView        * listTableview;
@property (nonatomic,strong) UITableView        * scheduleTableview;
@property (nonatomic,strong) TeamDetailInfoView * infoView;;
@property (nonatomic,strong) MBProgressHUD      * hud;
//@property (nonatomic,strong) UIBarButtonItem    * shareItem;
@property (nonatomic,strong) UIBarButtonItem    * favoriteItem;
@property (nonatomic,strong) UIBarButtonItem    * blankItem;
@property (nonatomic,strong) ShareView          * shareView;
@property (nonatomic,strong) UIView             * maskView;
@property (nonatomic,strong) UIBarButtonItem    * backItem;
@property (nonatomic,strong) CostomView         * photoview;
@property (nonatomic,strong) UIScrollView       * scrollView;
@property (nonatomic,strong) UIButton           * likeButton;
@property (nonatomic,strong) CenterAlertIView   * alartView;
@property (nonatomic,strong) UIButton           * listHeaderButton;
@property (nonatomic,strong) UIButton           * scheduleHeaderButton;
@property (nonatomic,strong) CommentBottomView  * bottomView;
@property (nonatomic,strong) PictureShowView    * pictureShowView;
@end

@implementation SEMTeamHomeViewController
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[SEMTeamHomeModel alloc] initWithDictionary:dictionary];
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
    self.navigationItem.rightBarButtonItems = @[self.favoriteItem];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
    [self.scrollView addSubview:self.infoView];
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
        make.top.equalTo(self.logoImageView.mas_bottom).offset(5*self.view.scale);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    self.infoView.sd_layout
    .widthIs(self.view.width)
    .topEqualToView(self.scrollView)
    .leftEqualToView(self.scrollView);
    [self.scrollView setupAutoContentSizeWithBottomView:self.infoView bottomMargin:20];
}
- (void)bindModel
{
    //当加载完毕之后隐藏hud
    [RACObserve(self.viewModel, loadingStatus) subscribeNext:^(id x) {
        if (self.viewModel.loadingStatus == 5) {
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
            UIImage* image = [UIImage imageNamed:@"camera_L"];
            self.photoview = [[CostomView alloc] initWithInfo:@"相册" image:image FontSize:14];
            self.photoview.label.textColor = [UIColor whiteColor];
            self.photoview.alpha = 0.5;
            
            [self.view addSubview:self.photoview];
            [self.photoview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.logoImageView.mas_right);
                make.bottom.equalTo(self.logoImageView.mas_bottom).offset(-8*self.view.scale);
                make.height.equalTo(@(14*self.view.scale));
                make.width.equalTo(@(60*self.view.scale));
            }];
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                SEMTeamPhotoController* controller = [HRTRouter objectForURL:@"photo" withUserInfo:@{@"id":@(self.viewModel.model.info.id)}];
                [self.navigationController pushViewController:controller animated:YES];
            }];
            [self.photoview.label addGestureRecognizer:tap];
            self.infoView.model = self.viewModel.InfoModel;
        }
    }];
    [RACObserve(self.viewModel, shouldUpdateRecord) subscribeNext:^(id x) {
        if (self.viewModel.shouldUpdateRecord == YES) {
            self.infoView.model = self.viewModel.InfoModel;
        }
    }];
    [RACObserve(self.viewModel, shouldUpdateList) subscribeNext:^(id x) {
        if (self.viewModel.shouldUpdateList == YES) {
            [self.listTableview reloadData];
        }
    }];
    [RACObserve(self.viewModel, shouldUpdateSchedule) subscribeNext:^(id x) {
        if (self.viewModel.shouldUpdateSchedule == YES) {
            [self.scheduleTableview reloadData];
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
            self.viewModel.content = nil;
            self.bottomView.sendButton.enabled = NO;
        }
    }];
    [RACObserve(self.viewModel, sholdReloadCommentTable2) subscribeNext:^(id x) {
        if (self.viewModel.sholdReloadCommentTable2 == YES) {
            [self.messageTableview reloadData];
            [self.messageTableview.mj_footer endRefreshing];
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
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.view addSubview:self.alartView];
            self.viewModel.pickerIndex = RECORDINDEX;
        }];
    self.infoView.userInteractionEnabled = YES;
    self.infoView.allButton.userInteractionEnabled = YES;
    self.infoView.allButton.imageView.userInteractionEnabled = YES;
    [self.infoView.allButton addGestureRecognizer:tap];
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
#pragma mark -pickerviewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.viewModel.pickerViewDataSource.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.viewModel.pickerViewDataSource[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60*self.view.scale;
}
- (void)didClickDoneButton:(CenterAlertIView *)view index:(NSInteger)selectedIndex
{
    [self.alartView removeFromSuperview];
    NSLog(@"%@",self.viewModel.pickerViewDataSource[selectedIndex]);
    NSLog(@"%ld",(long)self.viewModel.pickerIndex);
    NSString* date = self.viewModel.pickerViewDataSource[selectedIndex];
    switch (self.viewModel.pickerIndex) {
        case 1:
            [self.infoView.allButton setTitle:self.viewModel.pickerViewDataSource[selectedIndex] forState:UIControlStateNormal];
            [self.viewModel loadSRecord:date];
            break;
        case 2:
            [self.listHeaderButton setTitle:self.viewModel.pickerViewDataSource[selectedIndex] forState:UIControlStateNormal];
            [self.viewModel loadList:date];
            break;
        case 3:
            [self.scheduleHeaderButton setTitle:self.viewModel.pickerViewDataSource[selectedIndex] forState:UIControlStateNormal];
            [self.viewModel loadSchedule:date];
            break;
        default:
            break;
    }
    
    self.alartView = nil;
}
#pragma mark- tableiviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        return 1;
    }
    else if (tableView.tag == NEWSTABLEVIEWTAG)
    {
        return 1;
    }
    else if (tableView.tag == LISTTABLEVIEWTAG)
    {
        if(kArrayIsEmpty(self.viewModel.players.coaches))
        {
            return 1;
        }
        return 2;
    }
    else if(tableView.tag == SCHEDULETABLEVIETAG)
    {
        return self.viewModel.games.count;
    }
    else if(tableView.tag == 104)
    {
        return 0;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        return self.viewModel.newsModel.count;
    }
    else if (tableView.tag == NEWSTABLEVIEWTAG)
    {
        return self.viewModel.model.articles.count;
    }
    else if (tableView.tag == LISTTABLEVIEWTAG)
    {
        if(kArrayIsEmpty(self.viewModel.players.coaches))
        {
            if (self.viewModel.players.captain) {
                return self.viewModel.players.players.count + 1;
            }
            return self.viewModel.players.players.count;
        }
        switch (section) {
            case 0:
                return self.viewModel.players.coaches.count;
                break;
            case 1:
                if (self.viewModel.players.captain) {
                    return self.viewModel.players.players.count + 1;
                }
                return self.viewModel.players.players.count;
                break;
            default:
                break;
        }
    }
    else if(tableView.tag == SCHEDULETABLEVIETAG)
    {
        return self.viewModel.games[section].games.count;
    }
    else if (tableView.tag == 104)
    {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
        NewsCommentCell* cell = [[NewsCommentCell alloc] init];
        cell.model = self.viewModel.newsModel[indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if (tableView.tag == NEWSTABLEVIEWTAG)
    {
        Articles* news = self.viewModel.model.articles[indexPath.row];
        TeamNewsCell* cell = (TeamNewsCell*)[tableView dequeueReusableCellWithIdentifier:@"TeamNewsCell"];
        cell.model = news;
        return cell;
    }
    
    else if (tableView.tag == LISTTABLEVIEWTAG)
    {
        if(kArrayIsEmpty(self.viewModel.players.coaches))
        {
            UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TeamPlayerCell"];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
            cell.textLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
            if (self.viewModel.players.captain) {
                
                if (indexPath.row == 0) {
                    cell.textLabel.text = self.viewModel.players.captain.player.name;
                    cell.detailTextLabel.text = @"队长";
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
                }
                else
                {
                    cell.textLabel.text = self.viewModel.players.players[indexPath.row - 1].player.name;
                }
            }
            
            else
            {
                cell.textLabel.text = self.viewModel.players.players[indexPath.row].player.name;
            }
            
            return cell;
        }
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TeamPlayerCell"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
        cell.textLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
        
        if (indexPath.section == 0) {
            cell.textLabel.text = self.viewModel.players.coaches[indexPath.row].coach.name;
        }
        
        else
        {
            if (self.viewModel.players.captain) {
                
                if (indexPath.row == 0) {
                    cell.textLabel.text = self.viewModel.players.captain.player.name;
                    cell.detailTextLabel.text = @"队长";
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
                }
                else
                {
                    cell.textLabel.text = self.viewModel.players.players[indexPath.row - 1].player.name;
                }
            }
            else
            {
                cell.textLabel.text = self.viewModel.players.players[indexPath.row].player.name;
            }
        }
        return cell;
    }
    

    else if (tableView.tag == SCHEDULETABLEVIETAG)
    {
        NoticeGameviewCell* cell = [[NoticeGameviewCell alloc] init];
        GameDetailModel* model1 = self.viewModel.games[indexPath.section];
        Games* model = model1.games[indexPath.row];
        cell.model = model;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == MESSAGETABLEVIEWTAG) {
         CGFloat height = [tableView cellHeightForIndexPath:indexPath model:self.viewModel.newsModel[indexPath.row] keyPath:@"model" cellClass:[NewsCommentCell class]  contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return height;
    }
    else if(tableView.tag == NEWSTABLEVIEWTAG)
    {
        return 120 * self.view.scale;
    }
    else if (tableView.tag == LISTTABLEVIEWTAG)
    {
        return 48 * self.view.scale;
    }
    else if (tableView.tag == SCHEDULETABLEVIETAG) {
        GameDetailModel* model1 = self.viewModel.games[indexPath.section];
        Games* model = model1.games[indexPath.row];
        if (model.latestNews.detail) {
            return 196 * self.view.scale;
        }
        return 156*self.view.scale;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == LISTTABLEVIEWTAG) {
        return 48 * self.view.scale;
    }
    else if (tableView.tag == SCHEDULETABLEVIETAG)
    {
        return 35*self.view.scale;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == SCHEDULETABLEVIETAG) {
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc] init];
    view.frame = CGRectMake(0, 0, self.view.width, 16*self.view.scale);
    [view addSubview:label];
    NSString* string;
    string = [self.viewModel.games[section] getDate1];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = NSMakeRange(0, string.length);
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithHexString:@"#999999"]
     
                          range:range];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*self.view.scale] range:range];
    label.attributedText = AttributedStr;
    label.textAlignment = NSTextAlignmentCenter;
    view.backgroundColor = [UIColor BackGroundColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    return view;
    }
    else if (tableView.tag == LISTTABLEVIEWTAG)
    {
        UILabel* label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14*self.view.scale];
        label.backgroundColor = [UIColor BackGroundColor];
        if (kArrayIsEmpty(self.viewModel.players.coaches)) {
            label.text = @"   队员";
            return label;
        }
        if (section == 0) {
            label.text = @"   主教练";
        }
        else
        {
            label.text = @"   队员";
        }
        
        return label;
    }
    return nil;
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == LISTTABLEVIEWTAG)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0 && self.viewModel.model.info.coach)
        {
            CoachDetailViewController *controller= [[CoachDetailViewController alloc] initWithDictionary:@{@"id":@(self.viewModel.model.info.coach.id),@"coach":@"YES"}];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (indexPath.section == 0 && kArrayIsEmpty(self.viewModel.players.coaches))
        {
            NSInteger inde;
            if (self.viewModel.players.captain) {
                if (indexPath.row == 0 &&self.viewModel.players.captain) {
                    inde = self.viewModel.players.captain.player.id;
                }
                else if(indexPath.row != 0 && self.viewModel.players.captain)
                {
                    inde = self.viewModel.players.players[indexPath.row - 1].player.id;
                }
            }
            else
            {
                inde = self.viewModel.players.players[indexPath.row].player.id;
            }
            
            PlayerDetailViewController *controller= [[PlayerDetailViewController alloc] initWithDictionary:@{@"id":@(inde)}];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if(indexPath.section == 1)
        {
            NSInteger inde;
            if (self.viewModel.players.captain) {
                if (indexPath.row == 0 &&self.viewModel.players.captain) {
                    inde = self.viewModel.players.captain.player.id;
                }
                else if(indexPath.row != 0 && self.viewModel.players.captain)
                {
                    inde = self.viewModel.players.players[indexPath.row - 1].player.id;
                }
            }
            else
            {
                inde = self.viewModel.players.players[indexPath.row].player.id;
            }
        
            PlayerDetailViewController *controller= [[PlayerDetailViewController alloc] initWithDictionary:@{@"id":@(inde)}];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else if (tableView.tag == NEWSTABLEVIEWTAG)
    {
        
        NSInteger ide = self.viewModel.model.articles[indexPath.row].id;
        SEMNewsDetailController* controller = [[SEMNewsDetailController alloc] initWithDictionary:@{@"ides":@(ide)}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView.tag == SCHEDULETABLEVIETAG)
    {
        RaceInfoDetailController* controller = [[RaceInfoDetailController alloc] initWithDictionay:@{@"id":@(self.viewModel.games[indexPath.section].games[indexPath.row].id)}];
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
        [_pageView initTab:YES Gap:self.view.width / 5 TabHeight:40*self.view.scale VerticalDistance:0 BkColor:[UIColor whiteColor]];
        [_pageView addTab:@"资料" View:self.scrollView Info:nil];
        [_pageView addTab:@"名单" View:self.listTableview Info:nil];
        [_pageView addTab:@"赛程" View:self.scheduleTableview Info:nil];
        [_pageView addTab:@"新闻" View:self.newsTableview Info:nil];
        [_pageView addTab:@"留言" View:self.messageTableview Info:nil];
        [_pageView setTitleStyle:[UIFont systemFontOfSize:15*self.view.scale] SelFont:[UIFont systemFontOfSize:18*self.view.scale] Color:[UIColor colorWithHexString:@"#666666"] SelColor:[UIColor colorWithHexString:@"#1EA11F"]];
        [_pageView enableBreakLine:YES Width:1 TopMargin:0 BottomMargin:0 Color:[UIColor whiteColor]];
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
        _messageTableview.tag = MESSAGETABLEVIEWTAG;
        _messageTableview.contentSize = CGSizeMake(self.view.width, 2 * self.view.height);
        _messageTableview.bounces = NO;
        [_messageTableview registerClass:[NewsCommentCell class] forCellReuseIdentifier:@"NewsCommentCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _messageTableview.tableHeaderView = backView;
        _messageTableview.backgroundColor = [UIColor BackGroundColor];
        _messageTableview.separatorColor = [UIColor BackGroundColor];
        _messageTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreComment];
            [_messageTableview.mj_footer endRefreshing];
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
        _newsTableview.bounces = NO;
        [_newsTableview registerClass:[TeamNewsCell class] forCellReuseIdentifier:@"TeamNewsCell"];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _newsTableview.tableHeaderView = backView;
        _newsTableview.backgroundColor = [UIColor BackGroundColor];
        _newsTableview.separatorColor = [UIColor BackGroundColor];
        _newsTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreNews];
        }];
    }
    return _newsTableview;
}
- (UITableView*)listTableview
{
    if (!_listTableview) {
        _listTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableview.delegate = self;
        _listTableview.dataSource = self;
        _listTableview.tag = LISTTABLEVIEWTAG;
        _listTableview.bounces = NO;
        self.listHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.listHeaderButton.layer.borderWidth = 1;
        self.listHeaderButton.layer.borderColor = [UIColor BackGroundColor].CGColor;
        [self.listHeaderButton setImage:[UIImage imageNamed:@"calender_L"] forState:UIControlStateNormal];
        [self.listHeaderButton setTitle:@"全部" forState:UIControlStateNormal];
        self.listHeaderButton.titleLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
        [self.listHeaderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.listHeaderButton.frame = CGRectMake(0, 0, self.view.width, 40*self.view.scale);
        self.listHeaderButton.imageView.sd_layout
        .rightSpaceToView(self.listHeaderButton,12*self.view.scale)
        .centerYEqualToView(self.listHeaderButton)
        .heightIs(17.3*self.view.scale)
        .widthIs(19.4*self.view.scale);
        
        [self.listHeaderButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.listHeaderButton);
            make.height.equalTo(@(44*self.view.scale));
        }];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.view addSubview:self.alartView];
            self.viewModel.pickerIndex = LISTINDEX;
        }];
        [self.listHeaderButton addGestureRecognizer:tap1];
        _listTableview.tableHeaderView = self.listHeaderButton;
        _listTableview.separatorColor = [UIColor colorWithHexString:@"#EAEAEA"];
    }
    return _listTableview;
}
- (UITableView*)scheduleTableview
{
    if (!_scheduleTableview) {
        _scheduleTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scheduleTableview.delegate = self;
        _scheduleTableview.dataSource = self;
        _scheduleTableview.tag = SCHEDULETABLEVIETAG;
        _scheduleTableview.bounces = NO;
        [_scheduleTableview registerClass:[NoticeGameviewCell class] forCellReuseIdentifier:@"NoticeGameviewCell"];
        _scheduleTableview.backgroundColor = [UIColor BackGroundColor];
        _scheduleTableview.separatorColor = [UIColor BackGroundColor];
        self.scheduleHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.scheduleHeaderButton.layer.borderWidth = 1;
        self.scheduleHeaderButton.layer.borderColor = [UIColor BackGroundColor].CGColor;
        [self.scheduleHeaderButton setImage:[UIImage imageNamed:@"calender_L"] forState:UIControlStateNormal];
        [self.scheduleHeaderButton setTitle:@"全部" forState:UIControlStateNormal];
        self.scheduleHeaderButton.titleLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
        [self.scheduleHeaderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.scheduleHeaderButton.frame = CGRectMake(0, 0, self.view.width, 40*self.view.scale);
        self.scheduleHeaderButton.imageView.sd_layout
        .rightSpaceToView(self.scheduleHeaderButton,12*self.view.scale)
        .centerYEqualToView(self.scheduleHeaderButton)
        .heightIs(17.3*self.view.scale)
        .widthIs(19.4*self.view.scale);
        
        [self.scheduleHeaderButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.scheduleHeaderButton);
            make.height.equalTo(@(44*self.view.scale));
        }];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.view addSubview:self.alartView];
            self.viewModel.pickerIndex = GAMESINDEX;
        }];
        [self.scheduleHeaderButton addGestureRecognizer:tap2];
        self.scheduleHeaderButton.backgroundColor = [UIColor whiteColor];
        _scheduleTableview.tableHeaderView = self.scheduleHeaderButton;
        _scheduleTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.viewModel loadMoreSchdule];
            [_scheduleTableview.mj_footer endRefreshing];
        }];
    }
    return _scheduleTableview;
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
//- (ShareView *)shareView
//{
//    if (!_shareView) {
//        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, 200*self.view.scale)];
//        _shareView.layer.anchorPoint = CGPointMake(0, 0);
//        _shareView.frame = CGRectMake(0, self.view.height, self.view.width, 200*self.view.scale);
//        _shareView.delegate = self;
//        _shareView.layer.anchorPoint = CGPointMake(0, 0);
//        NSLog(@"%@",_shareView.description);
//    }
//    return _shareView;
//}
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
- (TeamDetailInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[TeamDetailInfoView alloc] initWithFrame:CGRectZero];
        _infoView.userInteractionEnabled = YES;
    }
    return _infoView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.width, 1000);
        _scrollView.tag = 1000;
        _scrollView.bounces = NO;
    }
    return _scrollView;
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
- (CenterAlertIView *)alartView
{
    if (!_alartView) {
        _alartView = [[CenterAlertIView alloc] init];
        _alartView.pickerView.delegate = self;
        _alartView.pickerView.dataSource = self;
        _alartView.frame = self.view.frame;
        _alartView.delegate = self;
    }
    return _alartView;
}
- (CommentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[CommentBottomView alloc] init];
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
    if (index == 3) {
        [self.newsTableview reloadData];
        [self.bottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
    }
    else if (index == 1)
    {
        [self.bottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        [self.listTableview reloadData];
    }
    else if (index == 4)
    {
        [self.messageTableview reloadData];
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
    }
    else if (index == 2)
    {
        [self.bottomView removeFromSuperview];
        [self.pictureShowView removeFromSuperview];
        [self.scheduleTableview reloadData];
    }
}

@end
