//
//  PersonalInfoController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PersonalInfoController.h"
#import "PersonalInfoViewModel.h"
#import "MDABizManager.h"
#import "SEMSearchViewController.h"
#import "ColleageSearchController.h"
@interface PersonalInfoController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,SEMSearchViewControllerDelegate,SearchCollegeDalegate>
@property (strong,nonatomic)PersonalInfoViewModel* viewModel;
@property (nonatomic,strong)UIDatePicker* datePickerView;
@property (nonatomic,strong)UIBarButtonItem* backItem;
@property (nonatomic,strong)UIImageView* headImageView;
@property (nonatomic,strong)UITableView* tableview;
@property (nonatomic,strong)UIImageView* logoImageView;
@property (nonatomic,strong)UIPickerView* genderPickerView;
@property (nonatomic,strong)UIBarButtonItem* submitItem;
@property (nonatomic,strong)UIBarButtonItem* cancelItem;
@end

@implementation PersonalInfoController
#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    // Do any additional setup after loading the view.
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
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItem = self.submitItem;
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.genderPickerView];
    [self.view addSubview:self.datePickerView];
}

- (void)makeConstraits
{
    self.headImageView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.view.scale * 212);
    
    self.logoImageView.sd_layout
    .centerXEqualToView(self.view)
    .heightIs(80 * self.view.scale)
    .topSpaceToView(self.view,100 * self.view.scale)
    .widthEqualToHeight();
    
    self.tableview.sd_layout
    .topSpaceToView(self.headImageView,0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.genderPickerView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(100 *self.view.scale)
    .bottomEqualToView(self.view);
    self.datePickerView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(150 *self.view.scale)
    .bottomEqualToView(self.view);
    self.logoImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
}
- (void)bindModel
{
    self.navigationItem.title = @"个人资料";
    if (self.viewModel.model.avatar) {
        NSURL* url = [[NSURL alloc] initWithString:self.viewModel.model.avatar];
        [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage placeholderImage]];
    }
    else
    {
        self.logoImageView.image = [UIImage placeholderImage];
    }
    [[self.viewModel.postCommand executionSignals] subscribeNext:^(id x) {
        [XHToast showCenterWithText:@"提交成功"];
    }];
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            [self.tableview reloadData];
        }
    }];
}
#pragma mark -SearchDelegate
- (void)didSelectedItem:(NSString *)name diplayname:(NSString *)dispalyname uni:(Universities *)uni
{
    self.viewModel.model.university = uni;
    [self.viewModel getDetail];
    [self.tableview reloadData];
}
#pragma mark- UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infocell"];
    cell.textLabel.text = self.viewModel.cellText[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    cell.textLabel.font = [UIFont systemFontOfSize:18* self.view.scale];
    cell.detailTextLabel.text = self.viewModel.cellDetail[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    cell.detailTextLabel.alpha = 0.87;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18 * self.view.scale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.mas_centerY);
        make.left.equalTo(cell.mas_left).offset(120 * self.view.scale);
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48 * self.view.scale;
}

#pragma mark-tableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        self.datePickerView.hidden = YES;
        self.genderPickerView.hidden = NO;
        self.navigationItem.leftBarButtonItem = self.cancelItem;
    }
    else if (indexPath.row == 3)
    {
        self.genderPickerView.hidden = YES;
        self.datePickerView.hidden = NO;
        self.navigationItem.leftBarButtonItem = self.cancelItem;
    }
    else if (indexPath.row == 0)
    {
        SEMSearchViewController* searchControlle = [HRTRouter objectForURL:@"search" withUserInfo:@{}];
        searchControlle.delegate = self;
        [self.navigationController pushViewController:searchControlle animated:true];
    }
    else
    {
        ColleageSearchController* searchControlle = [HRTRouter objectForURL:@"MEInfoColleageSearch" withUserInfo:@{@"code":@(self.viewModel.model.university.id)}];
        searchControlle.delegate = self;
        [self.navigationController pushViewController:searchControlle animated:true];
    }
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[PersonalInfoViewModel alloc] initWithDictionary: routerParameters];
}
#pragma  mark -collegersearchDelegate
- (void)didSelectedItem:(College *)uni
{
    self.viewModel.model.college = uni;
    [self.viewModel getDetail];
    [self.tableview reloadData];
}
#pragma mark -pickerviewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            return @"男";
            break;
        case 1:
            return @"女";
            break;
        default:
            return @"";
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.viewModel.model.gender = self.viewModel.gender[self.viewModel.genderArrat[row]];
    [self.viewModel getDetail];
    [self.tableview reloadData];
}
#pragma  mark -Getter
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 25, 20);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    
    }
    return _backItem;
}
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"头像背景"];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _headImageView;
}
- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
    }
    return _logoImageView;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
//        UITapGestureRecognizer*  tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            self.datePickerView.hidden = YES;
//            self.genderPickerView.hidden = YES;
//        }];
//        [_tableview addGestureRecognizer:tap];
    }
    return _tableview;
}
-(UIPickerView *)genderPickerView
{
    if (!_genderPickerView) {
        _genderPickerView = [[UIPickerView alloc] init];
        _genderPickerView.dataSource = self;
        _genderPickerView.delegate = self;
        _genderPickerView.hidden = YES;
        _genderPickerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _genderPickerView;
}
-(UIDatePicker *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] init];
        _datePickerView.backgroundColor = [UIColor lightGrayColor];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        _datePickerView.hidden = YES;
        [[_datePickerView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
            NSTimeInterval time = [self.datePickerView.date timeIntervalSince1970];
            self.viewModel.model.birthDay = time * 1000;
            [self.viewModel getDetail];
            [self.tableview reloadData];
        }];
        
    }
    return _datePickerView;
}
- (UIBarButtonItem *)submitItem
{
    if (!_submitItem) {
        _submitItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:nil action:nil];
        _submitItem.rac_command = self.viewModel.postCommand;
    }
    return _submitItem;
}
-(UIBarButtonItem *)cancelItem
{
    if (!_cancelItem) {
        _cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        
    }
    return _cancelItem;
}
- (void)cancel
{
    self.datePickerView.hidden = YES;
    self.genderPickerView.hidden = YES;
    self.navigationItem.leftBarButtonItem = self.backItem;
}
@end
