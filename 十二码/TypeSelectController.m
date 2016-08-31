//
//  TypeSelectController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TypeSelectController.h"
#import "MDABizManager.h"

@interface TypeSelectController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) UITableView          *tableView;
@property (nonatomic,strong) NSArray              *typeArray;

@end
@implementation TypeSelectController
#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    // Do any additional setup after loading the view.
}

#pragma viewsetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor BackGroundColor];
    [self addSubviews];
    [self makeConstraits];
    self.typeArray = @[@"5人场",@"6人场",@"7人场",@"8人场",@"9人场",@"11人场"];
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.tableView];
}
- (void)makeConstraits
{
    self.tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(48*self.view.scale*6);
}
#pragma mark- tableivewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = self.typeArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48*self.view.scale;
}
#pragma mark - tableviewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didSelectedItem:self.typeArray[indexPath.row]];
    
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
