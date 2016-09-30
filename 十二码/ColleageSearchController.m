//
//  ColleageSearchController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "MeColleageSearchViewModel.h"
#import "ColleageSearchController.h"
#import "MDABizManager.h"
@interface ColleageSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (strong,nonatomic)MeColleageSearchViewModel* viewModel;
@property (nonatomic,strong)UIBarButtonItem* backBarButtonItem;
@property (nonatomic,strong)UISearchBar* searchBar;
@property (nonatomic,strong)UITableView* tableView;


@end
@implementation ColleageSearchController
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.isSearching == YES) {
        return self.viewModel.universities.count;
    }
    else
    {
        NSArray* array = self.viewModel.dataSource;
        return array.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    College* uni;
    NSString* text = self.searchBar.text;
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"searchCell"];
    if (self.viewModel.isSearching == YES) {
        uni = self.viewModel.universities[indexPath.row];
        
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
        uni = self.viewModel.dataSource[indexPath.row];
        cell.textLabel.text = uni.name;
    }
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
    cell.textLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 * self.view.scale;
}
#pragma mark - UITableViewDelagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    College* uni;
    [self.searchBar resignFirstResponder];
    if (self.viewModel.isSearching == YES) {
        uni = self.viewModel.universities[indexPath.row];
    }
    else
    {
        uni = self.viewModel.dataSource[indexPath.row];

    }
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate didSelectedItem:uni];
    
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
        _searchBar.placeholder = @"搜索学院";
        _searchBar.translucent = YES;
        [_searchBar setTintColor:[UIColor colorWithHexString:@"#1EA11F"]];
    }
    return _searchBar;
}
- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EAEAEA"];
    }
    return _tableView;
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[MeColleageSearchViewModel alloc] initWithDictionary: routerParameters];
}
@end
