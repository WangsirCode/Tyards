//
//  MyMessageController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyMessageController.h"
#import "MDABizManager.h"
#import "MyMessageViewModel.h"
#import "MyMessageCell.h"
@interface MyMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)MyMessageViewModel* viewModel;
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)UIBarButtonItem* backItem;
@end

@implementation MyMessageController
#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self bindModel];
}
#pragma mark- setupView

- (void)setUpView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    [self makeConstraits];
}
- (void)addSubViews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.tableView];
}
- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}

- (void)bindModel
{
    self.navigationItem.title = @"我的消息";
    [RACObserve(self.viewModel, shouldReloadDate) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[MyMessageViewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark- tableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageCell* cell = (MyMessageCell*)[tableView dequeueReusableCellWithIdentifier:@"MyMessageCell"];
    cell.model = self.viewModel.model[indexPath.row].reply;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72 * self.view.scale;
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
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:NO completion:^(BOOL finished) {
                
            }];
        }];
    }
    return _backItem;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyMessageCell class] forCellReuseIdentifier:@"MyMessageCell"];
        _tableView.separatorColor = [UIColor BackGroundColor];
        _tableView.backgroundColor = [UIColor BackGroundColor];
    }
    return _tableView;
}
@end
