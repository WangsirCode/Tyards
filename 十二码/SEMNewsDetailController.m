//
//  SEMNewsDetailController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
//#import "TagsView.h"
//#import "TagsViewCell.h"
#import "SEMNewsDetailController.h"
#import "MDABizManager.h"
#import "NewsDetailViewModel.h"
#import "NewsDetailResponseModel.h"
//#import "TagsFrame.h"
#import "CommentCell.h"
#import "CommentView.h"
#import "ShareView.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"
@interface SEMNewsDetailController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,ShareViewDelegate,UMSocialUIDelegate>
@property (nonatomic,strong)NewsDetailViewModel* viewModel;
@property (nonatomic,strong)UIWebView* webView;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UILabel* infoLabbel;
@property (nonatomic,strong)UITableView* tableview;
@property (nonatomic,strong)UIView* headerView;
@property (nonatomic,strong)UIScrollView* scrollview;
@property (nonatomic,assign)CGFloat tableviewHeight;
@property (nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic,strong)UIBarButtonItem* shareItem;
@property (nonatomic,strong)UIBarButtonItem* favoriteItem;
@property (nonatomic,strong)UIBarButtonItem* blankItem;
@property (nonatomic,strong)ShareView* shareView;
@property (nonatomic,strong)UIView* maskView;
@end
@implementation SEMNewsDetailController
#pragma mark- lifeCycle
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[NewsDetailViewModel alloc] initWithDictionary: dictionary];
    }
    return self;
}
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

#pragma mark- setupview
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addsubviews];
    [self makeConstraits];
}
- (void)addsubviews
{
    self.navigationItem.rightBarButtonItems = @[self.shareItem];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
}
- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];

    
    _scrollview.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    [_scrollview sd_addSubviews:@[self.titleLabel,self.infoLabbel,self.webView,self.tableview]];
    self.titleLabel.sd_layout
    .topSpaceToView(_scrollview,31*scale)
    .leftSpaceToView(_scrollview,10*scale)
    .rightEqualToView(_scrollview)
    .autoHeightRatio(0);
    
    self.infoLabbel.sd_layout
    .topSpaceToView(self.titleLabel,27*scale)
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .autoHeightRatio(0);
    

    [_scrollview setupAutoContentSizeWithBottomView:self.tableview bottomMargin:10];
    
}
- (void)bindModel
{

    [RACObserve(self.viewModel, isLoaded) subscribeNext:^(id x) {
        if ([x  isEqual: @(YES)]) {
            NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
            CGFloat scale = [data floatForKey:@"scale"];
            
            NSMutableString * text = [NSMutableString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>",scale * 375];
            if (self.viewModel.newdetail.text) {
                [text appendString:self.viewModel.newdetail.text]; ;
            }
            else
            {
                [text appendString:self.viewModel.newdetail.detail];
            }
            [self.webView loadHTMLString:text baseURL:nil];
            self.webView.scrollView.scrollEnabled = YES;
            self.infoLabbel.text = [self.viewModel.newdetail getInfo];
            self.titleLabel.text = self.viewModel.newdetail.title;
            self.navigationItem.title = self.titleLabel.text;
            self.tableview.tableHeaderView = self.headerView;
            [self.tableview reloadData];
        }
    }];
    [RACObserve(self.viewModel, getHeight) subscribeNext:^(id x) {
        if (self.viewModel.getHeight == YES && self.viewModel.heightSet == NO) {
            //为什么会重复执行numberOfRowsInSection:?
            self.viewModel.heightSet = YES;
            self.tableview.sd_resetLayout
            .topSpaceToView(self.webView,10)
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .heightIs(self.tableviewHeight);
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
    [[self.viewModel.likeCommand executionSignals] subscribeNext:^(id x) {
        NSLog(@"s收到了收藏信号");
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
#pragma mark- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.newdetail) {
        return self.viewModel.newdetail.comments.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell* cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.model = self.viewModel.newdetail.comments[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self.tableview cellHeightForIndexPath:indexPath model:self.viewModel.newdetail.comments[indexPath.row] keyPath:@"model" cellClass:[CommentCell class]  contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    if (self.viewModel.heightSet == NO) {
        self.tableviewHeight += height;
    }

    if (indexPath.row == (self.viewModel.newdetail.comments.count - 1)) {
        self.viewModel.getHeight = YES;
    }
    return height;
}
#pragma mark -webviewdelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.hud.labelText = @"加载中";
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //为什么无法获取到真实高度？
//    CGFloat webViewHeight= [[self.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] intValue];
    
    //如果文字较少，则不用进行scrollViewDidScroll中的设置
    if (self.viewModel.newdetail.text.length < 500) {
        self.webView.sd_layout
        .topSpaceToView(self.infoLabbel,10)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .heightIs(200);
        self.webView.scrollView.scrollEnabled = NO;
        self.scrollview.scrollEnabled = YES;
    }
    
    else
    {
        self.webView.sd_layout
        .topSpaceToView(self.infoLabbel,10)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .heightIs(500);
    }
    [self.hud hide:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.viewModel.webViewLoaded == NO && scrollView.contentSize.height != 200) {

        //获取真实的高度
        CGFloat a = scrollView.contentSize.height;
        self.webView.sd_resetLayout
        .topSpaceToView(self.infoLabbel,10)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .heightIs(a);
        NSLog(@"%f",a);
        self.viewModel.webViewLoaded = YES;
        self.webView.scrollView.scrollEnabled = NO;
        self.scrollview.scrollEnabled =YES;
    }
    
}
- (void)didSelectedShareView:(NSInteger)index
{
    WXMediaMessage* mes = [WXMediaMessage message];
    [mes setThumbImage:[UIImage imageNamed:@"zhanwei.jpg"]];
    mes.title = self.viewModel.newdetail.title;
    mes.description = @"我在十二码发送了一片文章";
    WXWebpageObject* web = [WXWebpageObject object];
    web.webpageUrl = @"www.baidu.com";
    mes.mediaObject = web;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = WXSceneTimeline;
    switch (index) {
        case 0:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 1:
//            [WXApi sendReq:req];
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 2:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 3:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 4:
            [self hideMaskView];
            break;
        default:
            break;
    }
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[NewsDetailViewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark-getter
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    return  _titleLabel;
}
- (UILabel*)infoLabbel
{
    if (!_infoLabbel) {
        _infoLabbel = [[UILabel alloc] init];
        _infoLabbel.font = [UIFont systemFontOfSize:13];
        _infoLabbel.textColor = [UIColor colorWithHexString:@"C8C8C8"];
    }
    return _infoLabbel;
}
- (UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor lightGrayColor];
    }
    return _webView;
}
- (UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        [_tableview registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    }
    return _tableview;
}
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [UIView new];
        UILabel* uplabel = [UILabel new];
        uplabel.text = @"相关";
        uplabel.textAlignment = NSTextAlignmentLeft;
        [_headerView addSubview:uplabel];
        uplabel.sd_layout
        .topSpaceToView(_headerView,10)
        .leftSpaceToView(_headerView,10)
        .rightSpaceToView(_headerView,10)
        .autoHeightRatio(0);
        
        
        UIView* tagview = [UIView new];
        [_headerView addSubview:tagview];
        NSMutableArray *temp = [NSMutableArray new];
        NSInteger count = self.viewModel.newdetail.tags.count;
        if (count > 0) {
            NSArray<Tag*>* strings = self.viewModel.newdetail.tags;
            for (int i = 0; i < count; i++) {
                UILabel* label = [UILabel new];
                label.layer.borderWidth = 1;
                label.textColor = [UIColor colorWithHexString:@"#1EA11f"];
                label.text = strings[i].text;
                label.font = [UIFont systemFontOfSize:16];
                label.layer.borderColor = [UIColor colorWithHexString:@"#C8C8C8"].CGColor;
                label.textAlignment = NSTextAlignmentCenter;
                [tagview addSubview:label];
                label.sd_layout.autoHeightRatio(0);
                [temp addObject:label];
            }
            
            // 此步设置之后_autoMarginViewsContainer的高度可以根据子view自适应
            [tagview setupAutoMarginFlowItems:[temp copy] withPerRowItemsCount:3 itemWidth:80 verticalMargin:10 verticalEdgeInset:4 horizontalEdgeInset:10];
            
            tagview.sd_layout
            .leftSpaceToView(_headerView, 10)
            .rightSpaceToView(_headerView, 10)
            .topSpaceToView(uplabel, 20);
        }
        UILabel* commentLabel = [UILabel new];
        commentLabel.text = @"精彩评论";
        commentLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
        [_headerView addSubview:commentLabel];
        if (count > 0) {
            commentLabel.sd_layout
            .topSpaceToView(tagview,22)
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .heightIs(20);
        }
        else
        {
            commentLabel.sd_layout
            .topSpaceToView(uplabel,22)
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .heightIs(20);
        }
        [_headerView setupAutoHeightWithBottomView:commentLabel bottomMargin:0];
        [_headerView layoutSubviews];
        self.tableviewHeight += _headerView.frame.size.height;
        
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
-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        
        //避免刚开始滑动时就滑动
        _scrollview.scrollEnabled = NO;
    }
    return _scrollview;
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
@end
