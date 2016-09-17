//
//  SEMTeamViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamViewController.h"
#import "SEMTeamViewModel.h"
#import "NoticeCellView.h"
#import "GameListView.h"
#import "TeamLisstResponseModel.h"
#import "SEMTeamHomeViewController.h"
@interface SEMTeamViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)SEMTeamViewModel* viewModel;
@property (nonatomic,strong)UISearchBar* searchBar;
@property (nonatomic,strong)UITableView* tableView;
@end

@implementation SEMTeamViewController

#pragma mark- lifeCycle

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
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.tableView];
}

- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.view);
    }];
}
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"球队icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"球队icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"球队" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)bindModel
{
    [RACObserve(self.viewModel, needReloadTableview) subscribeNext:^(id x) {
        if ([x  isEqual: @YES]) {
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMTeamViewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark -initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTab];
    }
    return self;
}
#pragma mark- UISearBardelagate
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    if (searchText.length == 0) {
        self.viewModel.isSearching = NO;
        [self.tableView reloadData];
        [searchBar resignFirstResponder];
    }
    else
    {
        [[self.viewModel.searchCommand execute:searchText ] subscribeNext:^(id x) {
            NSLog(@"已经搜搜完成");
            self.viewModel.isSearching = YES;
            [self.tableView reloadData];
        }];
    }
    
    
}
#pragma mark- tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.viewModel.isSearching == YES) {
        return 3;
    }
    else
    {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == YES) {
        switch (section) {
            case 0:
                return self.viewModel.teams.univerisities.count;
                break;
            case 1:
                return self.viewModel.teams.colleges.count;
                break;
            case 2:
                return self.viewModel.teams.others.count;
            default:
                return 0;
                break;
        }
    }
    else
    {
        switch (section) {
            case 0:
                return self.viewModel.model.univerisities.count;
                break;
            case 1:
                return self.viewModel.model.colleges.count;
                break;
            case 2:
                return self.viewModel.model.others.count;
            default:
                return 0;
                break;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Team * uni;
    NSString* text = self.searchBar.text;
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TeamsearchCell"];
    if (self.viewModel.isSearching == YES) {
        switch (indexPath.section) {
            case 0:
                uni = self.viewModel.teams.univerisities[indexPath.row];
                break;
            case 1:
                uni = self.viewModel.teams.colleges[indexPath.row];
                break;
            case 2:
                uni = self.viewModel.teams.others[indexPath.row];
                break;
            default:
                break;
        }
        //设置富文本
        NSRange rangeToSearchWithin = NSMakeRange(0, [uni.name length]);
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:uni.name];
        for (int i = 0; i < text.length; i++) {
            NSString* substring = [text substringWithRange:NSMakeRange(i, 1)];
            NSRange searchResult = [uni.name rangeOfString:substring options:nil range:rangeToSearchWithin];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor colorWithHexString:@"#1EA11F"]
             
                                  range:searchResult];
            cell.textLabel.attributedText = AttributedStr;
        
        }
    }
    else
    {
        switch (indexPath.section) {
            case 0:
                uni = self.viewModel.model.univerisities[indexPath.row];
                break;
            case 1:
                 uni = self.viewModel.model.colleges[indexPath.row];
                break;
            case 2:
                uni = self.viewModel.model.others[indexPath.row];
                break;
            default:
                break;
        }
        
        cell.textLabel.text = uni.name;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == NO) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.right.equalTo(view);
            make.left.equalTo(view).offset(10);
        }];
        switch (section) {
            case 0:
                titleLabel.text = @"校队";
                break;
            case 1:
                titleLabel.text = @"学院队";
                break;
            case 2:
                titleLabel.text = @"其他";
                break;
            default:
                break;
        }
        
        titleLabel.font = [UIFont systemFontOfSize:20];
        
        [titleLabel setTextColor:[UIColor colorWithHexString:@"#1EA11F"]];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    else
    {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 20)];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.right.equalTo(view);
            make.left.equalTo(view).offset(10);
        }];
        switch (section) {
            case 0:
                titleLabel.text = @"校队";
                break;
            case 1:
                titleLabel.text = @"学院队";
                break;
            case 2:
                titleLabel.text = @"其他";
                break;
            default:
                break;
        }
        
        titleLabel.font = [UIFont systemFontOfSize:20];
        
        [titleLabel setTextColor:[UIColor colorWithHexString:@"#1EA11F"]];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == YES) {
        if (section == 0 && !(self.viewModel.teams.univerisities.count > 0)) {
            return 0;
        }
        else  if(section == 1 && !(self.viewModel.teams.colleges.count > 0))
        {
            return 0;
        }
        else if (section == 2 && !(self.viewModel.teams.others.count > 0))
         {
             return 0;
         }
        else
        {
            return 40;
        }
        
    }
    return 40;
}
#pragma mark-tableviewdelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger iden;
    if (self.viewModel.isSearching == NO) {
        switch (indexPath.section) {
            case 0:
                iden = self.viewModel.model.univerisities[indexPath.row].id;
                break;
            case 1:
                iden = self.viewModel.model.colleges[indexPath.row].id;
                break;
            case 2:
                iden = self.viewModel.model.others[indexPath.row].id;
                break;
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.section) {
            case 0:
                iden = self.viewModel.teams.univerisities[indexPath.row].id;
                break;
            case 1:
                iden = self.viewModel.teams.colleges[indexPath.row].id;
                break;
            case 2:
                iden = self.viewModel.teams.others[indexPath.row].id;
                break;
            default:
                break;
        }
    }
    SEMTeamHomeViewController* controller = [HRTRouter objectForURL:@"TeamHome" withUserInfo:@{@"ide":@(iden)}];
    controller.hidesBottomBarWhenPushed = YES;
    controller.navigationController.navigationBar.alpha = 0;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark- Getter
- (UISearchBar*)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索球队";
//        _searchBar.translucent = YES;
        [_searchBar setTintColor:[UIColor whiteColor]];
//        //        _searchBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//        _searchBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        [UISearchBar appearance].barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        //        [UISearchBar appearance].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    return _searchBar;
}
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
