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
#import "PlayerDetailViewController.h"
#import "CoachDetailViewController.h"
#import "GameInfoDetailViewController.h"
#import "SEMTeamHomeViewController.h"
@interface MyConcernController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) MyConcernViewModel * viewModel;
@property (nonatomic,strong) UITableView        * tableView;
@property (nonatomic,strong) UIBarButtonItem    * backItem;
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
    UIImageView* imageView = [UIImageView new];
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
    cell.textLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
    MyLabel* label = [[MyLabel alloc] init];
    label.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    label.text = @"取消关注";
    label.font = [UIFont systemFontOfSize:12*self.view.scale];
    label.textColor = [UIColor colorWithHexString:@"#1EA11f"];
    label.layer.borderWidth = 1;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderColor = [UIColor colorWithHexString:@"#1EA11F"].CGColor;
    [cell.contentView addSubview:label];
    label.sd_layout
    .centerYEqualToView(cell.contentView)
    .rightSpaceToView(cell.contentView,10)
    .heightIs(25*self.view.scale)
    .widthIs(70*self.view.scale);
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self deFan:indexPath.row];
    }];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*self.view.scale;
}
#pragma mark  - TableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ConcernModel* model = self.viewModel.model[indexPath.row];
    if (model.player) {
        PlayerDetailViewController* controller = [[PlayerDetailViewController alloc] initWithDictionary:@{@"id":@(model.player.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (model.team)
    {
        SEMTeamHomeViewController* controller = [[SEMTeamHomeViewController alloc] initWithDictionary :@{@"ide":@(model.team.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (model.tournament)
    {
        GameInfoDetailViewController* controller = [[GameInfoDetailViewController alloc] initWithDictionay :@{@"id":@(model.tournament.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (model.coach)
    {
        CoachDetailViewController* controller = [[CoachDetailViewController alloc] initWithDictionary:@{@"id":@(model.coach.id)}];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
#pragma mark - deFan
- (void)deFan:(NSInteger)index
{
    ConcernModel* model = self.viewModel.model[index];
    NSMutableArray<ConcernModel*>* array = [NSMutableArray arrayWithArray:self.viewModel.model];
    [array removeObjectAtIndex:index];
    self.viewModel.model = nil;
    self.viewModel.model = array;
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    if (model.player.name) {
        [manager postdisLikePlayer:[@(model.player.id) stringValue] token:[self.viewModel getToken] success:^(id data) {
            [self.tableView reloadData];
        } failure:^(NSError *aError) {
            
        }];
    }
    else if (model.coach.name)
    {
        [manager postdislikeCoach:[@(model.coach.id) stringValue] token:[self.viewModel getToken] success:^(id data) {
            [self.tableView reloadData];
        } failure:^(NSError *aError) {
            
        }];
    }
    else if (model.tournament.name)
    {
        [manager postdisLikeTournament:[@(model.tournament.id) stringValue] token:[self.viewModel getToken] success:^(id data) {
            [self.tableView reloadData];
        } failure:^(NSError *aError) {
            
        }];
    }
    else
    {
        [manager postdisLikeTeam:[@(model.team.id) stringValue] token:[self.viewModel getToken] success:^(id data) {
            [self.tableView reloadData];
        } failure:^(NSError *aError) {
            
        }];
    }
}
#pragma  mark -Getter
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 15);
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
        _tableView.backgroundColor = [UIColor BackGroundColor];
        _tableView.separatorColor = [UIColor BackGroundColor];
    }
    return _tableView;
}
@end
