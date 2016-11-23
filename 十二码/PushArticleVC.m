//
//  PushArticleVC.m
//  十二码
//
//  Created by Hello World on 16/11/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PushArticleVC.h"
#import "MDABizManager.h"
#import "DraftsCell.h"
@interface PushArticleVC ()
@property (nonatomic,strong) UIBarButtonItem       * backItem;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic) int page;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation PushArticleVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.title=@"已发表的文章";
    self.page=1;
    self.dataArr=[NSMutableArray array];
    
    [self.table registerNib:[UINib nibWithNibName:@"DraftsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DraftsCell"];
    [self.table.mj_header beginRefreshing];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self refreshRequest:self.page];
        [self.table.mj_header endRefreshing];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refreshRequest:++self.page];
        [self.table.mj_footer endRefreshing];
    }];
}
-(void)refreshRequest:(NSInteger)page{

    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager myPosts:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"] university:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"universityId"] offset:page success:^(id data) {
        NSDictionary *dic =data;
        if (page==1) {
            [self.dataArr removeAllObjects];
        }
        if ([dic[@"code"] integerValue]==0) {
            NSArray *arr= dic[@"resp"];
            if (arr.count==0) {
                return;
            }else{
                [self.dataArr addObjectsFromArray:arr];
            }
        }
        [self.table reloadData];
    } failure:^(NSError *aError) {
        
    }];
}

#pragma mark -tableviewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"DraftsCell";
    DraftsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell setData:self.dataArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark -tableviewDeleagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -- UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    [self doSearch:searchBar];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    [self doSearch:searchBar];
}

- (void)doSearch:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *searchKey = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (searchKey == nil)
    {
        searchKey = @"";
    }

}

-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 15);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
