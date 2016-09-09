//
//  ChangeNickNameController.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ChangeNickNameController.h"
#import "MDABizManager.h"
#import "UserModel.h"
#import "ChangeNickNameViewModel.h"
@interface ChangeNickNameController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) ChangeNickNameViewModel* viewModel;
@property (nonatomic,strong) UIBarButtonItem      *saveItem;
@property (nonatomic,strong) UITextField          *textFiled;
@end
@implementation ChangeNickNameController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[ChangeNickNameViewModel alloc] initWithDictionary:dictionary];
    }
    return self;
}
#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    
    // Do any additional setup after loading the view.
}

#pragma viewsetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor BackGroundColor];
    [self addSubviews];
    [self makeConstraits];
    
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItem = self.saveItem;
    self.navigationItem.title = @"昵称";
    [self.view addSubview:self.textFiled];
}
- (void)makeConstraits
{
    self.textFiled.sd_layout
    .topSpaceToView(self.view,10)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(35*self.view.scale);
}
- (void)bindModel
{
    [RACObserve(self.textFiled, text) subscribeNext:^(id x) {
        self.viewModel.name = self.textFiled.text;
    }];
}

- (void)savaName
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager changeNickName:[self.viewModel getToken] name:self.viewModel.name success:^(id data) {
        UserModel* model = (UserModel*)[DataArchive unarchiveUserDataWithFileName:@"userinfo"];
        model.nickname = self.textFiled.text;
        [DataArchive archiveUserData:model withFileName:@"userinfo"];
        [XHToast showCenterWithText:@"修改成功"];
    } failure:^(NSError *aError) {
        
    }];
}
#pragma  mark- textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
#pragma mark- getter

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
-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}
- (UIBarButtonItem *)saveItem
{
    if (!_saveItem) {
        _saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savaName)];
    }
    return _saveItem;
}
-(UITextField *)textFiled
{
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.backgroundColor = [UIColor whiteColor];
        _textFiled.delegate = self;
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithString:self.viewModel.name];
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        style.firstLineHeadIndent = 15;
        [attr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.viewModel.name.length)];
        _textFiled.attributedText = attr;
        _textFiled.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _textFiled;
}
@end
