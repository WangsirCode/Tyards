//
//  SEMLoginViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMLoginViewController.h"
#import "MDABizManager.h"
#import "MeLoginView.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UserModel.h"
#import "LoginCommand.h"
#import "MeinfoViewModel.h"
@interface SEMLoginViewController ()<TencentSessionDelegate>

@property (nonatomic,strong)UIImageView* logoImageview;
@property (nonatomic,strong)UIButton* backButton;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UILabel* infoLabel;
@property (nonatomic,strong)MeLoginView* wexinView;
@property (nonatomic,strong)MeLoginView* qqView;
@property (nonatomic,strong)UILabel* bottomLabel;
@property (nonatomic,strong)UIImageView* backImage;
@property (nonatomic,strong)UIImageView* lineImage;
@property (nonatomic,strong) TencentOAuth* tencentOAuth;
@property (nonatomic,strong)MeinfoViewModel* viewModel;
@property (nonatomic,strong)LoginCommand* login;
@end

@implementation SEMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self makeConstraits];
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    view.userInteractionEnabled = YES;
    self.view = view;
}

- (void)addSubviews
{
    [self.view addSubview:self.logoImageview];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.backImage];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.logoImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width).dividedBy(3.14);
        make.height.equalTo(self.logoImageview.mas_width);
        make.top.equalTo(self.view.mas_top).offset(98*scale);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(45*scale);
        make.left.equalTo(self.view.mas_left).offset(12*scale);
        make.height.equalTo(self.view.mas_height).dividedBy(47.2);
        make.width.equalTo(self.view.mas_width).dividedBy(20.69);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageview.mas_bottom).offset(30*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(50*scale);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(7);
    }];
    [self.backImage addSubview:self.lineImage];
    [self.backImage addSubview:self.wexinView];
    [self.backImage addSubview:self.qqView];
    [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backImage);
        make.height.equalTo(self.backImage.mas_height).dividedBy(1.3);
        make.width.equalTo(@2);
    }];
    [self.wexinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImage.mas_top).offset(12);
        make.bottom.equalTo(self.backImage.mas_bottom).offset(-10);
        make.width.equalTo(self.backImage.mas_width).dividedBy(6);
        make.left.equalTo(self.backImage.mas_left).offset(60);
    }];
    [self.qqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImage.mas_top).offset(12*scale);
        make.bottom.equalTo(self.backImage.mas_bottom).offset(-10*scale);
        make.width.equalTo(self.backImage.mas_width).dividedBy(6);
        make.right.equalTo(self.backImage.mas_right).offset(-60);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImage.mas_bottom).offset(16*scale);
        make.centerX.equalTo(self.view);
    }];
    
}
- (void)bindModel
{
    self.login = [LoginCommand sharedInstance];
    [[self.login.weixinLoginedCommand executionSignals] subscribeNext:^(id x) {
        [XHToast showCenterWithText:@"登录成功"];
        [self dismiss];
    }];
    [[self.wexinView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"请求微信登录");
        if ([WXApi isWXAppInstalled]) {
            SendAuthReq* req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            [WXApi sendReq:req];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"微信登录" message:@"请先安装好微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    [[self.qqView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"请求qq登录");
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101273513" andDelegate:self];
        NSArray* permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t",nil];
        [_tencentOAuth authorize:permissions inSafari:NO];
    
    }];
}
#pragma mark- Getter
- (UIImageView*)logoImageview
{
    if (!_logoImageview) {
        _logoImageview = [[UIImageView alloc] init];
        _logoImageview.image = [UIImage imageNamed:@"足球logo"];
    }
    return _logoImageview;
}

- (UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"up-arrow"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventAllEvents];
        [_backButton setEnabled:YES];
    }
    return _backButton;
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:35];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"十二码";
    }
    return _titleLabel;
}

- (UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"曾经的足球梦，在这里实现";
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont systemFontOfSize:14];
    }
    return _infoLabel;
}
- (UIImageView*)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微信QQ矩形框"]];
        [_backImage setUserInteractionEnabled:YES];
    }
    return _backImage;
}

- (UIImageView*)lineImage
{
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微信QQ分割线"]];
    }
    return _lineImage;
}

- (UILabel*)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"通过以上方式快速登录十二码";
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bottomLabel;
}

- (MeLoginView*)wexinView
{
    if (!_wexinView) {
        _wexinView = [[MeLoginView alloc] initWithFrame:CGRectZero];
        _wexinView.title.text = @"微信登录";
        [_wexinView.button setImage:[UIImage imageNamed:@"微信icon"] forState:UIControlStateNormal];
        [_wexinView setUserInteractionEnabled:YES];
    }
    return _wexinView;
}

- (MeLoginView*)qqView
{
    if (!_qqView) {
        _qqView = [[MeLoginView alloc] initWithFrame:CGRectZero];
        _qqView.title.text = @"QQ登录";
        [_qqView.button setImage:[UIImage imageNamed:@"QQicon"] forState:UIControlStateNormal];
    }
    return _qqView;
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}



-(void)getUserInfoResponse:(APIResponse *)response
{
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        [DataArchive removeUserFile:@"UserInfo"];
        NSDictionary *userInfo = [response jsonResponse];
        UserModel* data = [[UserModel alloc] init];
        data.headimgurl = userInfo[@"figureurl_qq_1"];
        data.nickname = userInfo[@"nickname"];
        data.token = (NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
        [DataArchive archiveUserData:data withFileName:@"userinfo"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData* data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:data.headimgurl]];
            UIImage* imamge = [[UIImage alloc] initWithData:data1];
            [DataArchive archiveUserData:imamge withFileName:@"headimage"];
            [self dismiss];
        });
        
    } else {
        NSLog(@"QQ auth fail ,getUserInfoResponse:%d", response.detailRetCode);
    }
}
- (void)tencentDidLogin
{

    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        NSString* token = _tencentOAuth.accessToken;
        NSString* openID = _tencentOAuth.openId;
        SEMNetworkingManager* magager = [SEMNetworkingManager sharedInstance];
        [magager fetchQQToken:token openid:openID success:^(id data) {
            NSString* token = data;
            [DataArchive archiveUserData:token withFileName:@"token"];
            [_tencentOAuth getUserInfo];
        } failure:^(NSError *aError) {
            NSLog(@"%@",aError);
        }];

    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}
@end
