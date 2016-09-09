//
//  InvitationViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationViewController.h"
#import "AlbumDetailController.h"
#import "MDABizManager.h"
#import "AlbumDetailViewModel.h"
#import "PhotoDetailCell.h"
#import "PictureShowController.h"
#import "InvitationVIewModel.h"
#import "InvitationView.h"
#import "InvitationViewCell.h"
#import "MyInvitationViewController.h"
#import "MakeInvitationController.h"
#import "DOPDropDownMenu.h"
#import "MakeInvitationController.h"
@interface InvitationViewController ()<UITableViewDelegate,UITableViewDataSource,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,MakeInvitationControllerDelegate>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) InvitationVIewModel  *viewModel;
@property (nonatomic,strong) UITableView          *invitationTableView;
@property (nonatomic,strong) UIBarButtonItem      *rightBarItem;
@property (nonatomic,strong) DOPDropDownMenu      *menu;
@end
@implementation InvitationViewController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[InvitationVIewModel alloc] initWithDictionary:dictionary];
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
    [self.menu selectDefalutIndexPath];
    self.hud.labelText = @"加载中";
    
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    [self.view addSubview:self.invitationTableView];
    [self.view addSubview:self.menu];
}
- (void)makeConstraits
{
    self.invitationTableView.sd_layout
    .topSpaceToView(self.menu,0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    self.menu.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(44*self.view.scale);
}
- (void)bindModel
{
    self.navigationItem.title = @"约战";
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            [self.hud hide:YES];
            [self.invitationTableView reloadData];
        }
    }];
}
#pragma mark - MakeInvitationDelegate
- (void)didMakeInvitation:(InvitationModel *)model
{
    NSMutableArray* array = [NSMutableArray arrayWithObject:model];
    [array addObjectsFromArray:self.viewModel.model];
    self.viewModel.model = nil;
    self.viewModel.model = array;
    [self.invitationTableView reloadData];
    [XHToast showCenterWithText:@"发布成功"];
}
#pragma  mark - tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvitationViewCell* cell = (InvitationViewCell*)[tableView dequeueReusableCellWithIdentifier:@"InvitationViewCell"];
    cell.view.model = self.viewModel.model[indexPath.row];
    cell.contentView.backgroundColor = [UIColor BackGroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 212*self.view.scale;
}
#pragma mark -DOPDropDownMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 1;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    return self.viewModel.menuArray.count;
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return self.viewModel.menuArray[indexPath.row];
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    [self.viewModel didSelectItem:indexPath.row];
    [self.invitationTableView reloadData];
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
- (UITableView *)invitationTableView
{
    if (!_invitationTableView) {
        _invitationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _invitationTableView.delegate = self;
        _invitationTableView.dataSource = self;
        [_invitationTableView registerClass:[InvitationViewCell class] forCellReuseIdentifier:@"InvitationViewCell"];
        _invitationTableView.separatorColor = [UIColor BackGroundColor];
    }
    return _invitationTableView;
}
- (UIBarButtonItem *)rightBarItem
{
    if (!_rightBarItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 6, 20);
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* makePost = [UIAlertAction actionWithTitle:@"下战帖" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MakeInvitationController* controler = [[MakeInvitationController alloc] initWithDictionary:@{}];
                controler.delegate = self;
                [self.navigationController pushViewController:controler animated:YES];
            }];
            UIAlertAction* myPost = [UIAlertAction actionWithTitle:@"我的战帖" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MyInvitationViewController* controler = [[MyInvitationViewController alloc] initWithDictionary:@{}];
                [self.navigationController pushViewController:controler animated:YES];
            }];
            [alert addAction:cancel];
            [alert addAction:makePost];
            [alert addAction:myPost];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
    return _rightBarItem;
}
- (DOPDropDownMenu *)menu
{
    if (!_menu) {
        _menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
        _menu.backgroundColor = [UIColor MyColor];
        _menu.delegate = self;
        _menu.dataSource = self;
    }
    return _menu;
}
@end
