//
//  SEMSearchViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMSearchViewController.h"
#import "ReactiveCocoa.h"
#import "SEMSearchViewModel.h"
#import "SearchModel.h"
#import "MDABizManager.h"
@interface SEMSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIBarButtonItem* backBarButtonItem;
@property (nonatomic,strong)UISearchBar* searchBar;
@property (nonatomic,strong)SEMSearchViewModel* viewModel;
@property (nonatomic,strong)UITableView* tableView;

@end

@implementation SEMSearchViewController

#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.tableView];
}
- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.view);
    }];
}

- (void)bindModel
{
    [RACObserve(self.viewModel, needReloadTableview) subscribeNext:^(id x) {
        if ([x  isEqual: @YES]) {
            [self.tableView reloadData];
        }
    }];
}
#pragma mark -tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.viewModel.isSearching == YES) {
        return 1;
    }
    else
    {
        return self.viewModel.datasource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == YES) {
        return self.viewModel.universities.count;
    }
    else
    {
        NSArray* array = self.viewModel.datasource[section].universities;
        return array.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Universities* uni;
    NSString* text = self.searchBar.text;
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"searchCell"];
    if (self.viewModel.isSearching == YES) {
        uni = self.viewModel.universities[indexPath.row];
        
        //设置富文本
        NSRange rangeToSearchWithin = NSMakeRange(0, [uni.displayName length]);
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:uni.displayName];
        for (int i = 0; i < text.length; i++) {
            NSString* substring = [text substringWithRange:NSMakeRange(i, 1)];
            NSRange searchResult = [uni.displayName rangeOfString:substring options:nil range:rangeToSearchWithin];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor colorWithHexString:@"#1EA11F"]
             
                                  range:searchResult];
            cell.textLabel.attributedText = AttributedStr;
            
        }
    }
    else
    {
        uni = self.viewModel.datasource[indexPath.section].universities[indexPath.row];
        cell.textLabel.text = uni.displayName;
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = uni.city;
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
        titleLabel.text = self.viewModel.datasource[section].name;
        titleLabel.font = [UIFont systemFontOfSize:20];
        
        [titleLabel setTextColor:[UIColor colorWithHexString:@"#1EA11F"]];
        view.backgroundColor = [UIColor lightTextColor];
        return view;
    }
    else
    {
        return nil;
    }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == YES) {
        return 0;
    }
    return 40;
}
#pragma mark - UITableViewDelagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* name;
    NSString* dispalyname;
    [self.searchBar resignFirstResponder];
    if (self.viewModel.isSearching == YES) {
        name = self.viewModel.universities[indexPath.row].code;
        dispalyname = self.viewModel.universities[indexPath.row].displayName;
    }
    else
    {
        name = self.viewModel.datasource[indexPath.section].universities[indexPath.row].code;
        dispalyname = self.viewModel.datasource[indexPath.section].universities[indexPath.row].displayName;
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didSelectedItem:name diplayname:dispalyname];
    
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


#pragma mark- Getter
- (UIBarButtonItem*)backBarButtonItem
{
    UIImage* image = [UIImage imageNamed:@"返回icon"];
    
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage: image forState: UIControlStateNormal];
    [[button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView: button];
    return someBarButtonItem;
}
- (UISearchBar*)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 2, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索学校";
        _searchBar.translucent = YES;
        [_searchBar setTintColor:[UIColor whiteColor]];
//        _searchBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _searchBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
       [UISearchBar appearance].barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        [UISearchBar appearance].backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
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
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMSearchViewModel alloc] initWithDictionary: routerParameters];
}
@end
