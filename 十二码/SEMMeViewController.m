//
//  SEMMeViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMMeViewController.h"
#import "SEMMeViewModel.h"
#import "MeinfoVIew.h"
#import "MeTopView.h"
#import "MDABizManager.h"
#import "SEMLoginViewController.h"
#import  "LoginCommand.h"
#import "UserModel.h"
#import "PersonalInfoController.h"
#import "UIViewController+MMDrawerController.h"
#import "SEMTabViewController.h"
#import "MyConcernController.h"
#import "MyMessageController.h"
#import "InvitationViewController.h"
#import "FeedBackController.h"
#import "ChangeNickNameController.h"
@interface SEMMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)SEMMeViewModel* viewModel;
@property (nonatomic,strong)MeTopView* topView;
@property (nonatomic,strong)UITableView* tableview;
@property (nonatomic,strong)LoginCommand* login;
@end

@implementation SEMMeViewController

#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewModel.info = (UserModel*)[DataArchive unarchiveUserDataWithFileName:@"userinfo"];
    if (self.viewModel.info) {
        self.topView.name = self.viewModel.info.nickname;
       // NSURL* url = [[NSURL alloc] initWithString:self.viewModel.info.headimgurl];
//        [self.topView.userHeadView sd_setImageWithURL:url placeholderImage:[UIImage placeholderImage]];
        self.topView.userHeadView.image = (UIImage*)[DataArchive unarchiveUserDataWithFileName:@"headimage"];
        self.topView.infoView.hidden = NO;
        self.viewModel.isLogined = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
                
            }];
            
            UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
            
            PersonalInfoController* controller = [HRTRouter objectForURL:@"myInfo" withUserInfo:@{}];
            controller.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:controller animated:YES];
        }];
        [self.topView.userHeadView addGestureRecognizer:tap];
    }
    else
    {
        self.topView.name = @"请登录";
        self.topView.headImage = [UIImage imageNamed:@"Group 2"];
        self.topView.infoView.hidden = YES;
        self.viewModel.isLogined = NO;
    }
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

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
}

- (void)addSubviews
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableview];
}

- (void)makeConstraits
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2.8);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@(48*7*self.view.scale));
    }];
}

- (void)bindModel
{
    self.title = self.viewModel.title;
    self.login = [LoginCommand sharedInstance];
    [[self.login.weixinLoginedCommand executionSignals] subscribeNext:^(id x) {
//        self.viewModel.info = x;
//        NSLog(@"%@",self.viewModel.info.nickname);
//        NSLog(@"成功获取用户信息");
    }];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
            
        }];
        ChangeNickNameController* controller =[[ChangeNickNameController alloc] initWithDictionary:@{@"name":self.viewModel.info.nickname}];
        UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
        controller.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:controller animated:YES];
    }];
    [self.topView.infoView.infoLabel addGestureRecognizer:tap];
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMMeViewModel alloc] initWithDictionary: routerParameters];
}

#pragma mark- uitableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeViewCell"];
    cell.imageView.image = [UIImage imageNamed:self.viewModel.images[indexPath.row]];
    [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.left.equalTo(cell.contentView.mas_left).offset(9);
    }];
    cell.textLabel.text = self.viewModel.items[indexPath.row];
    [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(35);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
        {
            return 48*self.view.scale;
        }
#pragma  mark-TableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进入个人资料页面
    if (indexPath.row == 0) {
        if (self.viewModel.isLogined) {
            [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
                
            }];
            
            UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
            
            PersonalInfoController* controller = [HRTRouter objectForURL:@"myInfo" withUserInfo:@{}];
            controller.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:controller animated:YES];
        }
        else
        {
            [XHToast showCenterWithText:@"请先登录"];
        }
        
    }
    else if (indexPath.row == 1)
    {
        if (self.viewModel.isLogined) {
            [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
            }];
            UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
            
            MyConcernController* controller = [HRTRouter objectForURL:@"Myconcern" withUserInfo:@{@"id":@(self.viewModel.model.id)}];
            controller.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:controller animated:YES];
        }
        else
        {
            [XHToast showCenterWithText:@"请先登录"];
        }
        
    }
    else if (indexPath.row == 2)
    {
        if (self.viewModel.isLogined) {
            [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
            }];
            UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
            
            MyMessageController* controller = [HRTRouter objectForURL:@"MyMessage" withUserInfo:@{}];
            controller.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:controller animated:YES];
        }
        else
        {
             [XHToast showCenterWithText:@"请先登录"];
        }

    }
    else if (indexPath.row == 6)
    {
        [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
        }];
        UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
        
        MyMessageController* controller = [HRTRouter objectForURL:@"setup" withUserInfo:@{@"login":@(self.viewModel.isLogined)}];
        controller.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 3)
    {
        [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
        }];
        UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
        InvitationViewController* controller = [[InvitationViewController alloc] initWithDictionary:@{}];
        controller.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 4)
    {
        FeedBackController* controller = [[FeedBackController alloc] init];
        [self.mm_drawerController closeDrawerAnimated: YES completion:^(BOOL finished) {
        }];
        UINavigationController* nav = (UINavigationController*)(((SEMTabViewController*)self.mm_drawerController.centerViewController).selectedViewController);
        controller.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:controller animated:YES];
        
    }
}
#pragma mark -Getter
- (MeTopView*)topView
{
    if (!_topView) {
        _topView = [[MeTopView alloc] initWithFrame:CGRectZero];
        _topView.name = @"爱足球的宝贝";
        _topView.headImage = [UIImage imageNamed:@"logo"];
        _topView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if (self.viewModel.isLogined == NO) {
                SEMLoginViewController* login = [HRTRouter objectForURL:@"login" withUserInfo:@{}];
                [self presentViewController:login animated:YES completion:nil];
            }
        }];
        [_topView.userHeadView addGestureRecognizer:tap];
    }
    return _topView;
}

- (UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.separatorInset = UIEdgeInsetsMake(0, 35, 0, 0);
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
@end
