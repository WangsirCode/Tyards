//
//  MakeInvitationController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MakeInvitationController.h"
#import "MDABizManager.h"
#import "MakeInvitationViewModel.h"
@interface MakeInvitationController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) MakeInvitationViewModel         *viewModel;
@property (nonatomic,strong) UIBarButtonItem      *rightBarItem;
@property (nonatomic,strong) UITableView          *postTableView;
@property (nonatomic,strong) UIButton             *postButton;
@property (nonatomic,strong) UITextView           *messageView;
@property (nonatomic,strong) UITextField          *titleFiled;
@property (nonatomic,strong) UITextField          *cmanFiled;
@property (nonatomic,strong) UITextField          *cteleFiled;
@property (nonatomic,strong) UIDatePicker         *datePicker;
@property (nonatomic,strong) UIDatePicker         *timePicker;
@property (nonatomic,strong) UILabel              *dateLabel;
@property (nonatomic,strong) UILabel              *timeLabel;
@property (nonatomic,strong) UILabel              *placeLabel;
@property (nonatomic,strong) UILabel              *typeLabel;
@property (nonatomic,strong) UIBarButtonItem      *doneItem;
@property (nonatomic,strong) UIBarButtonItem      *cancelItem;
@end
@implementation MakeInvitationController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[MakeInvitationViewModel alloc] initWithDictionary:dictionary];
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
    [self.view addSubview:self.postTableView];
    [self.view addSubview:self.postButton];
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.timePicker];
}
- (void)makeConstraits
{
    self.postTableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.postButton.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(48*self.view.scale);
    
    self.datePicker.sd_layout
    .bottomSpaceToView(self.postButton,0)
    .heightIs(210*self.view.scale)
    .widthIs(self.view.width)
    .centerXEqualToView(self.view);
    
    self.timePicker.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.postButton,0)
    .widthIs(self.view.width)
    .heightIs(210*self.view.scale);
}
- (void)bindModel
{
    self.title = @"编辑战帖";
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            [self.hud hide:YES];
        }
    }];
}
#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.viewModel.titleArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = self.viewModel.titleArray[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        if(indexPath.row == 0)
        {
            [cell.contentView addSubview:self.titleFiled];
            self.titleFiled.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .widthIs(300)
            .heightIs(30*self.view.scale);
        }
        else if (indexPath.row == 1)
        {
            NSDate* date = [[NSDate alloc] init];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy年MM月dd日";
            self.dateLabel.text = [formatter stringFromDate:date];
            [cell.contentView addSubview:self.dateLabel];
            self.dateLabel.sd_layout
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .widthIs(200)
            .autoHeightRatio(0);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 2)
        {
            NSDate* date = [[NSDate alloc] init];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"HH: mm";
            self.timeLabel.text = [formatter stringFromDate:date];
            [cell.contentView addSubview:self.timeLabel];
            self.timeLabel.sd_layout
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .widthIs(200)
            .autoHeightRatio(0);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 3)
        {
            [cell.contentView addSubview:self.placeLabel];
            self.placeLabel.sd_layout
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .widthIs(300)
            .autoHeightRatio(0);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 4)
        {
            [cell.contentView addSubview:self.typeLabel];
            self.typeLabel.sd_layout
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .centerYEqualToView(cell.contentView)
            .widthIs(300)
            .autoHeightRatio(0);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(indexPath.row == 5)
        {
            [cell.contentView addSubview:self.cmanFiled];
            self.cmanFiled.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .widthIs(300)
            .heightIs(30*self.view.scale);
        }
        else if (indexPath.row == 6)
        {
            [cell.contentView addSubview:self.cteleFiled];
            self.cteleFiled.sd_layout
            .centerYEqualToView(cell.contentView)
            .leftSpaceToView(cell.contentView,98*self.view.scale)
            .widthIs(300)
            .heightIs(30*self.view.scale);
        }
        cell.userInteractionEnabled = YES;
        return cell;
    }
    else
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Acell"];
        [cell.contentView addSubview:self.messageView];
        cell.textLabel.text = @"备注";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        cell.textLabel.sd_layout
        .topSpaceToView(cell.contentView,17*self.view.scale)
        .leftSpaceToView(cell.contentView,10*self.view.scale)
        .autoHeightRatio(0)
        .widthIs(100);
        self.messageView.sd_layout
        .topSpaceToView(cell.textLabel,10)
        .leftEqualToView(cell.contentView)
        .rightEqualToView(cell.contentView)
        .bottomEqualToView(cell.contentView);
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            return 48*self.view.scale;
    }
    return 195*self.view.scale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor BackGroundColor];
    return view;
}
#pragma mark -tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1)
    {
        self.datePicker.hidden = NO;
        self.navigationItem.leftBarButtonItem = self.doneItem;
        self.navigationItem.rightBarButtonItem = self.cancelItem;
    }
    else if (indexPath.row == 2)
    {
        self.timePicker.hidden = NO;
        self.navigationItem.leftBarButtonItem = self.doneItem;
        self.navigationItem.rightBarButtonItem = self.cancelItem;
    }
}
#pragma mark -textViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textView.text = @"备注信息让各大球队提高对你的兴趣吧";
        textView.textColor = [UIColor colorWithHexString:@"#CACACA"];
    }
    else
    {
        textView.textColor = [UIColor colorWithHexString:@"000000"];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"备注信息让各大球队提高对你的兴趣吧"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
- (UITableView *)postTableView
{
    if (!_postTableView) {
        _postTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _postTableView.delegate = self;
        _postTableView.dataSource = self;
        _postTableView.separatorColor = [UIColor BackGroundColor];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor BackGroundColor];
        backView.frame = CGRectMake(0, 0, self.view.width, 8);
        _postTableView.tableHeaderView = backView;
        _postTableView.backgroundColor = [UIColor BackGroundColor];
    }
    return _postTableView;
}
 -(UIButton *)postButton
{
    if (!_postButton) {
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postButton setTitle:@"发布" forState:UIControlStateNormal];
        [_postButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _postButton.backgroundColor = [UIColor whiteColor];
        _postButton.rac_command = self.viewModel.postCommand;
    }
    return _postButton;
}
- (UITextView *)messageView
{
    if (!_messageView) {
        _messageView = [[UITextView alloc] init];
        _messageView.delegate = self;
        _messageView.text = @"备注信息让各大球队提高对你的兴趣吧";
        _messageView.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _messageView.font = [UIFont systemFontOfSize:14];
    }
    return _messageView;
}
- (UITextField *)titleFiled
{
    if (!_titleFiled) {
        _titleFiled = [[UITextField alloc] init];
        
    }
    return _titleFiled;
}
- (UITextField*)cmanFiled
{
    if (!_cmanFiled) {
        _cmanFiled = [[UITextField alloc] init];
    }
    return _cmanFiled;
}
- (UITextField *)cteleFiled
{
    if (!_cteleFiled) {
        _cteleFiled = [UITextField new];
    }
    return _cteleFiled;
}
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.date = [[NSDate alloc] init];
        _datePicker.center = self.view.center;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        _datePicker.locale = locale;
        _datePicker.backgroundColor = [UIColor BackGroundColor];
        _datePicker.hidden = YES;
    }
    return _datePicker;
}
- (UIDatePicker *)timePicker
{
    if (!_timePicker) {
        _timePicker = [UIDatePicker new];
        _timePicker.date = [[NSDate alloc] init];
        _timePicker.center = self.view.center;
        _timePicker.datePickerMode = UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        _timePicker.locale = locale;
        _timePicker.backgroundColor = [UIColor BackGroundColor];
        _timePicker.hidden = YES;
    }
    return _timePicker;
}
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
    }
    return _dateLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
    }
    return _timeLabel;
}
- (UILabel *)placeLabel
{
    if (!_placeLabel) {
        _placeLabel = [UILabel new];
    }
    return _placeLabel;
}
- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
    }
    return _typeLabel;
}
- (UIBarButtonItem *)cancelItem
{
    if (!_cancelItem) {
        _cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemAction)];
    }
    return _cancelItem;
}
- (void)cancelItemAction
{
    self.datePicker.hidden = YES;
    self.timePicker.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = self.backItem;
}
- (UIBarButtonItem *)doneItem
{
    if (!_doneItem) {
        _doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneItemAction)];
    }
    return _doneItem;
}
- (void)doneItemAction
{
    self.datePicker.hidden = YES;
    self.timePicker.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = self.backItem;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    self.dateLabel.text = [formatter stringFromDate:self.datePicker.date];
    formatter.dateFormat = @"HH: mm";
    self.timeLabel.text = [formatter stringFromDate:self.timePicker.date];
}
@end
