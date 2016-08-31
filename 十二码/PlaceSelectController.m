//
//  PlaceSelectController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlaceSelectController.h"
#import "MDABizManager.h"
#import "PlaceViewModel.h"
@interface PlaceSelectController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) PlaceViewModel* viewModel;
@property (nonatomic,strong) UITableView* tableView;
@end
@implementation PlaceSelectController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[PlaceViewModel alloc] initWithDictionary:@{}];
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
    [self.view addSubview:self.tableView];
}
- (void)makeConstraits
{

}
- (void)bindModel
{
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            self.tableView.sd_layout
            .topEqualToView(self.view)
            .leftEqualToView(self.view)
            .rightEqualToView(self.view)
            .heightIs(48*self.view.scale*self.viewModel.model.count);
            [self.tableView reloadData];
            [self.hud hide:YES];
        }
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = self.viewModel.model[indexPath.row].name;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48*self.view.scale;
}
#pragma  mark - tableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.delegate didSelectPlace:self.viewModel.model[indexPath.row].name iden:self.viewModel.model[indexPath.row].id];
    [self.navigationController popViewControllerAnimated:YES];
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor BackGroundColor];
    }
    return _tableView;
}
@end
