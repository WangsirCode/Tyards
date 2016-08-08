//
//  MyConcernController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyConcernController.h"
#import "MyConcernViewModel.h"
#import "MDABizManager.h"
@interface MyConcernController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)MyConcernViewModel* viewModel;
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)UIBarButtonItem* backItem;
@end


@implementation MyConcernController
#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self bindModel];
    // Do any additional setup after loading the view.
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
    self.navigationItem.title = @"我的关注";
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[MyConcernViewModel alloc] initWithDictionary: routerParameters];
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
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"concernCell"];
    NSString* string;
    ConcernModel* model = self.viewModel.model[indexPath.row];
    if (model.player) {
        string = model.player.name;
    }
    else if (model.team)
    {
        string = model.team.name;
    }
    else if (model.tournament)
    {
        string = model.tournament.name;
    }
    else if (model.coach)
    {
        string = model.coach.name;
    }
    cell.textLabel.text = string;
    cell.detailTextLabel.text = @" 取消关注 ";
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#1EA11f"];
    cell.detailTextLabel.layer.borderWidth = 1;
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.layer.borderColor = [UIColor colorWithHexString:@"#1EA11F"].CGColor;
    return cell;
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
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
