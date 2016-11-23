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
#import "MLImagePickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLImagePickerMenuTableViewCell.h"
#import "PictureShowView.h"
#import "CommentBottomView.h"
#import "SEMLoginViewController.h"
#import "TagLabels.h"
#import "MeUserInfoResponseModel.h"


#define kTimeLineTableViewCellId @"SDTimeLineCell"


@interface SEMNewsDetailController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,ShareViewDelegate,UMSocialUIDelegate,CommentCellDelegate,HZPhotoBrowserDelegate>
@property (nonatomic,strong)NewsDetailViewModel* viewModel;
@property (nonatomic,strong)UIWebView* webView;
@property (nonatomic,strong)UIBarButtonItem* backItem;
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
@property (nonatomic,strong)CommentBottomView  * bottomView;
@property (nonatomic,strong)UIButton *bottomBtn;

@property (nonatomic,strong) UIGestureRecognizer *recognizer;
@property (nonatomic,strong) NSMutableArray *mUrlArray;
@property (nonatomic,assign) CGFloat webViewHeight;
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
    self.tableviewHeight = 0;
    [self addsubviews];
    [self makeConstraits];
}
- (void)addsubviews
{
    self.navigationItem.rightBarButtonItems = @[self.shareItem];
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.bottomBtn];
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
    
    self.bottomView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(50*self.view.scale);

    [_scrollview setupAutoContentSizeWithBottomView:self.tableview bottomMargin:50*self.view.scale];
}
- (void)bindModel
{

    [RACObserve(self.viewModel, isLoaded) subscribeNext:^(id x) {
        if ([x  isEqual: @(YES)]) {
            NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
            CGFloat scale = [data floatForKey:@"scale"];
            
            NSMutableString * text = [NSMutableString stringWithFormat:@"<head><style>img{max-width:%dpx !important;}</style></head>",(int)(scale * 375)];
            if (self.viewModel.newdetail.text) {
                [text appendString:self.viewModel.newdetail.text]; ;
            }
            else
            {
                [text appendString:self.viewModel.newdetail.detail];
            }
            [self.webView loadHTMLString:text baseURL:nil];
            self.webView.scrollView.scrollEnabled = YES;
            
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] init];
            [attributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.viewModel.newdetail.author] attributes:nil]];
            [attributed addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor colorWithHexString:@"#1EA11F"]
             
                                  range:NSMakeRange(0, self.viewModel.newdetail.author.length)];
            [attributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@",[self.viewModel.newdetail getDateInfo]] attributes:nil]];
            self.infoLabbel.attributedText = attributed;
            self.titleLabel.text = self.viewModel.newdetail.title;
            self.navigationItem.title = self.titleLabel.text;
            self.tableview.tableHeaderView = self.headerView;
//            if (self.viewModel.newdetail.comments.count > 0) {
//                [_scrollview setupAutoContentSizeWithBottomView:self.tableview bottomMargin:10];
//            }
//            else
//            {
//                [self.scrollview addSubview:self.headerView];
//                [self.tableview removeFromSuperview];
//                self.headerView.sd_layout
//                .topSpaceToView(self.webView,10)
//                .leftEqualToView(self.scrollview)
//                .rightEqualToView(self.scrollview);
//                [_scrollview setupAutoContentSizeWithBottomView:self.headerView bottomMargin:10];
//            }
            [self.tableview reloadData];
        }
    }];
//    [RACObserve(self.viewModel, getHeight) subscribeNext:^(id x) {
//        if (self.viewModel.getHeight == YES && self.viewModel.heightSet == NO) {
////        if(self.viewModel.getHeight == YES)
////        {
////            为什么会重复执行numberOfRowsInSection:?
//            self.viewModel.heightSet = YES;
//            self.tableview.sd_resetLayout
//            .topSpaceToView(self.webView,10)
//            .leftEqualToView(self.view)
//            .rightEqualToView(self.view)
//            .heightIs(self.tableviewHeight);
////            self.viewModel.getHeight = NO;
////            self.viewModel.heightSet = NO;
//        }
//    }];
    [RACObserve(self.viewModel, shouldReloadCommentTable) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadCommentTable == YES) {
            self.viewModel.isTableView = YES;
            self.viewModel.getHeight = NO;
            self.viewModel.heightSet = NO;
            self.tableviewHeight = 0;
            [self.tableview reloadData];
            self.bottomView.textField.placeholder = @"说点什么吧";
            self.bottomView.textField.text = nil;
            [XHToast showCenterWithText:@"发表成功" duration:1];
            self.viewModel.postType = 1;
            self.bottomView.sendButton.enabled = NO;
            self.viewModel.content = nil;
            self.tableviewHeight+= 30;
            self.tableview.sd_resetLayout
            .topSpaceToView(self.webView,10)
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .heightIs(self.tableviewHeight);
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
#pragma mark - bottomCommentViewset
- (void)setTapGesture
{
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
#pragma mark- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.newdetail.comments > 0) {
        return self.viewModel.newdetail.comments.count;
    }
    else
    {
        if (self.viewModel.isLoaded == YES) {
            self.viewModel.isTableView = NO;
            return 1;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.isTableView == YES) {
        CommentCell* cell = [[CommentCell alloc] init];
        cell.model = self.viewModel.newdetail.comments[indexPath.row];
        NSString *userId=(NSString*)[DataArchive unarchiveUserDataWithFileName:@"userId"];
        if ([userId integerValue]==cell.model.comment.creator.id) {
           UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc ]initWithTarget:self action:@selector(cellLongPress:)];
            [cell addGestureRecognizer:longPressGesture];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.isTableView == YES) {
        if (self.viewModel.newdetail.comments[indexPath.row]) {
            CGFloat height = [self.tableview cellHeightForIndexPath:indexPath model:self.viewModel.newdetail.comments[indexPath.row] keyPath:@"model" cellClass:[CommentCell class]  contentViewWidth:[UIScreen mainScreen].bounds.size.width];
                    if (self.viewModel.heightSet == NO) {
                            self.tableviewHeight += height;
                    }
            
            if (indexPath.row == (self.viewModel.newdetail.comments.count - 1)) {
                self.viewModel.getHeight = YES;
            }
            return height;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        self.viewModel.getHeight = YES;
        self.tableviewHeight = 10;
        return 10;
    }
}
-(void)cellLongPress:(UIGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.recognizer=recognizer;
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        view.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];
        
        UIButton *deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(40, self.view.height/2, ScreenWidth-80, 40);
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.backgroundColor=[UIColor whiteColor];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [deleteBtn addTarget:self action:@selector(deleteComment:) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [view addSubview:deleteBtn];
        
        UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(40, self.view.height/2+40, ScreenWidth-80, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.backgroundColor=[UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelComment:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancelBtn];
        
        [self.view addSubview:view];
    }
}
-(void)deleteComment:(UIButton*)sender{
    CGPoint location = [self.recognizer locationInView:self.tableview];
    NSIndexPath * indexPath = [self.tableview indexPathForRowAtPoint:location];
    
    NSInteger commendId=self.viewModel.newdetail.comments[indexPath.row].id;
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager deleteNews:self.shareId ifhotTopic:self.viewModel.isHotTopic targetCommentId:commendId token: [self.viewModel getToken] success:^(id data) {
        [sender.superview removeFromSuperview];
        [self.viewModel.newdetail.comments removeObjectAtIndex:indexPath.row];
        [self.tableview reloadData];
    } failure:^(NSError *aError) {
        
    }];
    
}
-(void)cancelComment:(UIButton*)sender{
    [sender.superview removeFromSuperview];
}
#pragma mark -webviewdelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.hud.labelText = @"加载中";
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //为什么无法获取到真实高度？
    _webViewHeight= [[self.webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] floatValue];
//    //如果文字较少，则不用进行scrollViewDidScroll中的设置
//    if (self.viewModel.newdetail.text.length < 500) {
//        self.webView.sd_layout
//        .topSpaceToView(self.infoLabbel,10)
//        .leftEqualToView(self.view)
//        .rightEqualToView(self.view)
//        .heightIs(200);
//        self.webView.scrollView.scrollEnabled = NO;
//        self.scrollview.scrollEnabled = YES;
//    }
//    
//    else
//    {
        self.webView.sd_layout
        .topSpaceToView(self.infoLabbel,10)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .heightIs(_webViewHeight);
//        self.tableview.sd_resetLayout
//        .leftEqualToView(self.view)
//        .rightEqualToView(self.view)
//        .topSpaceToView(self.webView,10);
//    }
    
//    CGFloat a = webView.height;
//    self.webView.sd_resetLayout
//    .topSpaceToView(self.infoLabbel,10)
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view)
//    .heightIs(a);
//    NSLog(@"%f",a);
//    self.viewModel.webViewLoaded = YES;
//    self.webView.scrollView.scrollEnabled = NO;
//    self.scrollview.scrollEnabled =YES;
//    self.tableview.sd_resetLayout
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view)
//    .topSpaceToView(self.webView,10)
//    .heightIs(self.tableviewHeight);
    [self.hud hide:YES];
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    [_mUrlArray removeObjectAtIndex:0];
    if (_mUrlArray.count >= 2) {
        [_mUrlArray removeLastObject];
    }
    //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
    
    //添加图片可点击js
    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //path 就是被点击图片的url
        int index = 0;
        for (int i=0; i<self.mUrlArray.count; i++) {
            if ([self.mUrlArray[i] isEqualToString:path]) {
                index=i;
            }
        }
        HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
        browserVc.sourceImagesContainerView = self.view;
        browserVc.imageCount = self.mUrlArray.count;
        browserVc.currentImageIndex = index;
        // 代理
        browserVc.delegate = self;
        // 展示图片浏览器
        [browserVc show];
        
        return NO;
    }
    return YES;
}

#pragma mark--HZPhotoBrowserDelegate
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{

    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:self.mUrlArray[index]]];
    return [UIImage imageWithData:data];
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [[NSURL alloc] initWithString:self.mUrlArray[index]];
    return url;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollview==scrollView) {
        NSInteger num =scrollView.contentOffset.y;
        if (num-_webViewHeight+120>0) {
            self.bottomBtn.hidden=YES;
        }else{
            self.bottomBtn.hidden=NO;
        }
    }
 
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
        self.tableview.sd_resetLayout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(self.webView,10)
        .heightIs(self.tableviewHeight);
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
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImgUrl]];
    UIImage *image = [UIImage imageWithData:data];
    if (!image) {
        image = [UIImage imageNamed:@"zhanwei.jpg"];
    }
    NSString *urlStr;
    if (self.viewModel.isHotTopic) {
        urlStr=[NSString stringWithFormat:@"http://dev.12yards.cn/news/hottopic/%ld",(long)self.shareId];
    }
    else{
        urlStr=[NSString stringWithFormat:@"http://dev.12yards.cn/news/index/%ld",(long)self.shareId];
    }
    switch (index) {
        case 0:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr;
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:self.shareTitle image:image location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 1:
//            [WXApi sendReq:req];
        {
            [UMSocialData defaultData].extConfig.wechatTimelineData.url =urlStr;
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:self.shareTitle image:image location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 2:
        {
            [UMSocialData defaultData].extConfig.qqData.url = urlStr;
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:self.shareTitle image:image location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 3:
        {
            [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:self.shareTitle image:image location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
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
#pragma mark - PostComment
- (void)didClickComment:(NSInteger)newsId targetName:(NSString *)targetName
{
    self.viewModel.targetCommentId = newsId;
    self.viewModel.postType = 2;
    self.bottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",targetName];
    self.bottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.bottomView.textField becomeFirstResponder];
}
- (void)didReplyComment:(NSInteger)newsId targetId:(NSInteger)targetId remindId:(NSInteger)remindID name:(NSString *)name
{
    self.viewModel.postType = 3;
    self.bottomView.textField.placeholder = [NSString stringWithFormat:@"回复%@",name];
    self.bottomView.imageButton.sd_resetLayout
    .widthIs(0);
    [self.bottomView.textField becomeFirstResponder];
    self.viewModel.remindId = remindID;
    self.viewModel.targetCommentId = targetId;
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
        _webView.scrollView.scrollEnabled = NO;
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
        NSInteger count = self.viewModel.newdetail.tags.count;
        if (count > 0) {
            UILabel* uplabel = [UILabel new];
            uplabel.text = @"相关";
            uplabel.textAlignment = NSTextAlignmentLeft;
            [_headerView addSubview:uplabel];
            uplabel.sd_layout
            .topSpaceToView(_headerView,10)
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .autoHeightRatio(0);
            TagLabels* tagView = [[TagLabels alloc] init];
            tagView.model = self.viewModel.newdetail.tags;
            [_headerView addSubview:tagView];
            tagView.sd_layout
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .topSpaceToView(uplabel,20*self.view.scale);
            UILabel* commentLabel = [UILabel new];
            commentLabel.text = @"精彩评论";
            commentLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
            [_headerView addSubview:commentLabel];
            commentLabel.sd_layout
            .topSpaceToView(tagView,22*self.view.scale)
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .heightIs(20*self.view.scale);
            [_headerView setupAutoHeightWithBottomView:commentLabel bottomMargin:0];
        }
        else
        {
            UILabel* commentLabel = [UILabel new];
            commentLabel.text = @"精彩评论";
            commentLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
            [_headerView addSubview:commentLabel];
            commentLabel.sd_layout
            .topSpaceToView(_headerView,22*self.view.scale)
            .leftSpaceToView(_headerView,10)
            .rightSpaceToView(_headerView,10)
            .heightIs(20*self.view.scale);
            [_headerView setupAutoHeightWithBottomView:commentLabel bottomMargin:0];
        }
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
        _scrollview.delegate=self;
        //避免刚开始滑动时就滑动
        _scrollview.scrollEnabled = YES;
    }
    return _scrollview;
}
- (CommentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[CommentBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor BackGroundColor];
        [self setTapGesture];
        _bottomView.imageButton.sd_resetLayout
        .widthIs(0)
        .leftEqualToView(_bottomView)
        .topEqualToView(_bottomView)
        .bottomEqualToView(_bottomView);
    }
    return _bottomView;
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
- (UIButton*)bottomBtn{
    
    if (!_bottomBtn) {
        _bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(self.view.width-60, self.view.height-110-64, 50, 50);
        [_bottomBtn addTarget:self action:@selector(bottomAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setImage:[UIImage imageNamed:@"newsdetail_btnBG_icon"] forState:UIControlStateNormal];
    }
    return _bottomBtn;
}
-(void)bottomAction{

    [self.scrollview   scrollRectToVisible:CGRectMake(0, _webViewHeight-120, self.view.width, self.view.height) animated:YES];
}




@end
