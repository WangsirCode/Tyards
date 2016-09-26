//
//  MyInvitationViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyInvitationViewController.h"
#import "MyInvitationViewModel.h"
#import "MDABizManager.h"
#import "LazyPageScrollView.h"
#import "MakeInvitationController.h"
#import "InvitationViewCell.h"
@interface MyInvitationViewController ()<LazyPageScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,MakeInvitationControllerDelegate>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) MyInvitationViewModel         *viewModel;
@property (nonatomic,strong) LazyPageScrollView   *pageView;
@property (nonatomic,strong) UITableView          *myInvitationTableView;
@property (nonatomic,strong) UITableView          *myClosedInvitationTableView;
@end
@implementation MyInvitationViewController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[MyInvitationViewModel alloc] initWithDictionary:dictionary];
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
    self.hud.labelText = @"加载中";
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.pageView];
}
- (void)makeConstraits
{
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
- (void)bindModel
{
    self.navigationItem.title = @"我的战帖";
    [RACObserve(self.viewModel, status) subscribeNext:^(id x) {
        if (self.viewModel.status == 2) {
            [self.myInvitationTableView reloadData];
            [self.hud hide:YES];
        }
    }];
}

#pragma  mark- tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return self.viewModel.myInvitaions.count;
    }
    else if(tableView.tag == 101)
    {
        return self.viewModel.myClosedInvitations.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        InvitationViewCell* cell = (InvitationViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyInvitation"];
        if(!cell)
        {
            cell = [[InvitationViewCell alloc] init];
        }
        cell.view.model = self.viewModel.myInvitaions[indexPath.row];
        cell.contentView.backgroundColor = [UIColor BackGroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView.tag == 101)
    {
        InvitationViewCell* cell = (InvitationViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MyClosedInvitation"];
        if (!cell) {
            cell = [[InvitationViewCell alloc] init];
        }
        cell.contentView.backgroundColor= [UIColor BackGroundColor];
        cell.view.model = self.viewModel.myClosedInvitations[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 212*self.view.scale;
}
#pragma mark - tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        InvitationModel* model = self.viewModel.myInvitaions[indexPath.row];
        MakeInvitationController* controller = [[MakeInvitationController alloc] initWithDictionary:@{@"model":model}];
        [self.navigationController pushViewController:controller animated:YES];
        self.viewModel.index = indexPath.row;
        controller.delegate = self;
    }
}
- (void)didMakeInvitation:(InvitationModel *)model
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:self.viewModel.myInvitaions];
    if (model) {
        [array replaceObjectAtIndex:self.viewModel.index withObject:model];
        self.viewModel.myClosedInvitations = array;
    }
    else
    {
        InvitationModel* model = array[self.viewModel.index];
        [array removeObjectAtIndex:self.viewModel.index];
        self.viewModel.myInvitaions = [array copy];
        NSMutableArray* close = [NSMutableArray arrayWithArray:self.viewModel.myClosedInvitations];
        [close insertObject:model atIndex:0];
        self.viewModel.myClosedInvitations = [close copy];
        [self.myClosedInvitationTableView reloadData];
    }
    [self.myInvitationTableView reloadData];
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
- (LazyPageScrollView*)pageView
{
    if (!_pageView) {
        _pageView = [[LazyPageScrollView alloc] init];
        _pageView.frame =self.view.frame;
        _pageView.delegate = self;
        [_pageView initTab:YES Gap:self.view.width / 2 TabHeight:40 VerticalDistance:10 BkColor:[UIColor whiteColor]];
        [_pageView addTab:@"发布中" View:self.myInvitationTableView Info:nil];
        [_pageView addTab:@"已关闭" View:self.myClosedInvitationTableView Info:nil];
        [_pageView setTitleStyle:[UIFont systemFontOfSize:15] SelFont:[UIFont systemFontOfSize:20] Color:[UIColor blackColor] SelColor:[UIColor colorWithHexString:@"#1EA11F"]];
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
- (UITableView *)myInvitationTableView
{
    if (!_myInvitationTableView) {
        _myInvitationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myInvitationTableView.delegate = self;
        _myInvitationTableView.dataSource =self;
        _myInvitationTableView.tag = 100;
        [_myInvitationTableView registerClass:[InvitationViewCell class] forCellReuseIdentifier:@"MyInvitation"];
        _myInvitationTableView.separatorColor = [UIColor BackGroundColor];
        _myInvitationTableView.backgroundColor = [UIColor BackGroundColor];
    }
    return _myInvitationTableView;
}
- (UITableView *)myClosedInvitationTableView
{
    if (!_myClosedInvitationTableView) {
        _myClosedInvitationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myClosedInvitationTableView.delegate = self;
        _myClosedInvitationTableView.dataSource =self;
        _myClosedInvitationTableView.tag = 101;
        [_myClosedInvitationTableView registerClass:[InvitationViewCell class] forCellReuseIdentifier:@"MyClosedInvitation"];
        _myClosedInvitationTableView.backgroundColor = [UIColor BackGroundColor];
        _myClosedInvitationTableView.separatorColor = [UIColor BackGroundColor];
    }
    return _myClosedInvitationTableView;
}
#pragma mark -LazyPageScrollViewDelegate
-(void)LazyPageScrollViewPageChange:(LazyPageScrollView *)pageScrollView Index:(NSInteger)index PreIndex:(NSInteger)preIndex TitleEffectView:(UIView *)viewTitleEffect SelControl:(UIButton *)selBtn
{
    if (index == 1) {
        [self.myClosedInvitationTableView reloadData];
    }
    else if (index == 0)
    {
        [self.myInvitationTableView reloadData];
    }
}
@end
