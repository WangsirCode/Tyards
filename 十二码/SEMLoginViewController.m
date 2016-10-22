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
#import "TokenResponseModel.h"
#import "MeinfoViewModel.h"
#import "SEMRegVC.h"
#import "SEMForgetVC.h"


@interface SEMLoginViewController ()<TencentSessionDelegate,WXApiDelegate>

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
@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) UIView *accView;
@property (nonatomic,strong) UIView *passView;
@property (nonatomic,strong) UIImageView *accImg;
@property (nonatomic,strong) UIImageView *passImg;
@property (nonatomic,strong) UITextField *accTF;
@property (nonatomic,strong) UITextField *passTF;
@property (nonatomic,strong) UIButton *regBtn;
@property (nonatomic,strong) UIButton *passBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@end

@implementation SEMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([WXApi isWXAppInstalled]){
        self.wexinView.hidden=NO;
    }else{
        self.wexinView.hidden=YES;
    }
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
    [self.view addSubview:self.accView];
    [self.view addSubview:self.passView];
    [self.view addSubview:self.regBtn];
    [self.view addSubview:self.passBtn];
    [self.view addSubview:self.loginBtn];
    [self.accView addSubview:self.accTF];
    [self.accView addSubview:self.accImg];
    [self.passView addSubview:self.passTF];
    [self.passView addSubview:self.passImg];
    
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
        make.top.equalTo(self.view.mas_top).offset(70*scale);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(45*scale);
        make.left.equalTo(self.view.mas_left).offset(12*scale);
        make.height.equalTo(self.view.mas_height).dividedBy(47.2);
        make.width.equalTo(self.view.mas_width).dividedBy(20.69);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageview.mas_bottom).offset(20*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.accView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(15*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(30*scale);
        make.height.offset(40*scale);
        
    }];
    [self.accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accView.mas_top);
        make.left.equalTo(self.accView.mas_left);
        make.bottom.equalTo(self.accView.mas_bottom);
        make.width.offset(30*scale);
        
    }];
    [self.accTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.accView.mas_right);
        make.top.equalTo(self.accView.mas_top);
        make.bottom.equalTo(self.accView.mas_bottom);
        make.left.equalTo(self.accImg.mas_right);

    }];
    [self.passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accView.mas_bottom).offset(15*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(30*scale);
        make.height.offset(40*scale);
        
    }];
    [self.passImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passView.mas_top);
        make.left.equalTo(self.passView.mas_left);
        make.bottom.equalTo(self.passView.mas_bottom);
        make.width.offset(30*scale);
        
    }];
    [self.passTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passView.mas_right);
        make.top.equalTo(self.passView.mas_top);
        make.bottom.equalTo(self.passView.mas_bottom);
        make.left.equalTo(self.passImg.mas_right);
        
    }];
    [self.regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passView.mas_bottom).offset(10*scale);
        make.left.equalTo(self.passView.mas_left);
        make.height.offset(40*scale);
        make.width.offset(50*scale);
    }];
    [self.passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passView.mas_bottom).offset(10*scale);
        make.right.equalTo(self.passView.mas_right);
        make.height.offset(40*scale);
        make.width.offset(100*scale);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passView.mas_bottom).offset(65*scale);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(70*scale);
        make.height.offset(30*scale);
    }];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(225*scale);
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
//        if ([WXApi isWXAppInstalled]) {
            SendAuthReq* req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
//            [WXApi sendReq:req];
            [WXApi sendAuthReq:req viewController:self delegate:self];
//            sendAuthReq:(SendAuthReq*)req viewController:(UIViewController*)viewController delegate:(id<WXApiDelegate>)delegate
//        }
//        else
//        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"微信登录" message:@"请先安装好微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
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
        _logoImageview.image = [UIImage imageNamed:@"logo"];
        _logoImageview.layer.cornerRadius = 20*self.view.scale;
        _logoImageview.layer.masksToBounds = YES;
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
        _infoLabel.text = @"我们自己的绿茵青春";
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
    }
    return _infoLabel;
}
-(UIView *)accView{
    if (!_accView) {
        _accView = [[UIView alloc] init];
        _accView.backgroundColor=[UIColor whiteColor];
    }
    return _accView;
}
-(UIImageView*)accImg{
    if (!_accImg) {
        _accImg = [[UIImageView alloc] init];
        _accImg.contentMode=UIViewContentModeCenter;
        [_accImg setImage:[UIImage imageNamed:@"acc_icon"]];
    }
    return _accImg;
}
-(UIView *)passView{
    if (!_passView) {
        _passView = [[UIView alloc] init];
        _passView.backgroundColor=[UIColor whiteColor];
    }
    return _passView;
}
-(UIImageView*)passImg{
    if (!_passImg) {
        _passImg = [[UIImageView alloc] init];
        _passImg.contentMode=UIViewContentModeCenter;

        [_passImg setImage:[UIImage imageNamed:@"pass_icon"]];
    }
    return _passImg;
}
-(UITextField*)accTF{
    if (!_accTF) {
        _accTF = [[UITextField alloc] init];
        _accTF.placeholder = @"请输入邮箱账号";
        _accTF.backgroundColor=[UIColor whiteColor];
        _accTF.font = [UIFont systemFontOfSize:15*self.view.scale];
    }
    return _accTF;
}
-(UITextField*)passTF{
    if (!_passTF) {
        _passTF = [[UITextField alloc] init];
        _passTF.placeholder = @"请输入密码";
        _passTF.backgroundColor=[UIColor whiteColor];
        _passTF.secureTextEntry=YES;
        _passTF.font = [UIFont systemFontOfSize:15*self.view.scale];
    }
    return _passTF;
}
- (UIButton*)regBtn
{
    if (!_regBtn) {
        _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_regBtn setTitle:@"注册"  forState:UIControlStateNormal];
        _regBtn.titleLabel.font= [UIFont systemFontOfSize: 15];
        [_regBtn addTarget:self action:@selector(regAction) forControlEvents:UIControlEventAllEvents];
    }
    return _regBtn;
}
- (UIButton*)passBtn
{
    if (!_passBtn) {
        _passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passBtn setTitle:@"找回密码"  forState:UIControlStateNormal];
        _passBtn.titleLabel.font= [UIFont systemFontOfSize: 15];
        [_passBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventAllEvents];
    }
    return _passBtn;
}
- (UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录"  forState:UIControlStateNormal];
        _loginBtn.titleLabel.font= [UIFont systemFontOfSize: 15];
        _loginBtn.layer.borderColor=[UIColor whiteColor].CGColor;
        _loginBtn.layer.borderWidth=1;
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventAllEvents];
    }
    return _loginBtn;
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
        if (self.url) {
            data.headimgurl = self.url;
        }
        else
        {
            data.headimgurl = userInfo[@"figureurl_qq_2"];
        }
        if (self.nickname) {
            data.nickname = self.nickname;
        }
        else
        {
            data.nickname = userInfo[@"nickname"];
        }
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
            TokenModel* model = data;
            NSString* token = model.token;
            self.url = model.user.avatar;
            self.nickname = model.user.nickname;
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
-(void)regAction{
    SEMRegVC *vc =[[SEMRegVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];

}
-(void)forgetAction{
    SEMForgetVC *vc =[[SEMForgetVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];

}
-(void)loginAction{
    if (![self isValidateEmail:self.accTF.text]) {
        [XHToast showCenterWithText:@"请输入有效的邮箱账号"];

    }else if (self.passTF.text.length==0){
        [XHToast showCenterWithText:@"请输入邮箱密码"];

    }else{
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager log:self.accTF.text  password:self.passTF.text success:^(id data) {
            if (data) {
                TokenModel* model = data;
                NSString* token = model.token;
                self.url = model.user.avatar;
                [DataArchive archiveUserData:token withFileName:@"token"];
                
                UserModel* data = [[UserModel alloc] init];
                data.nickname = model.user.nickname;
                data.token = (NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
                [DataArchive archiveUserData:data withFileName:@"userinfo"];
                [self dismiss];

            }else{
                [XHToast showCenterWithText:@"登录失败"];

            }
        } failure:^(NSError *aError) {
            NSLog(@"%@",aError);
            [XHToast showCenterWithText:@"登录失败"];
        }]; 
    }
    
}
//判断是否是有效的邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
