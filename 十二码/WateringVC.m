//
//  WateringVC.m
//  十二码
//
//  Created by Hello World on 16/11/2.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "WateringVC.h"
#import "WriteVC.h"
#import "WateringCell.h"
#import "MDABizManager.h"

@interface WateringVC ()
@property (weak, nonatomic) IBOutlet UIButton *waritBtn;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) int page;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSString *searchStr;
@end

@implementation WateringVC
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
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"资讯icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"资讯icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"基友" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.searchBar resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.table.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"基友";
    self.page=1;
    self.dataArr=[NSMutableArray array];
    self.searchStr=@"";
    [self.table registerNib:[UINib nibWithNibName:@"WateringCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WateringCell"];
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self refreshRequest:1];
        [self.table.mj_header endRefreshing];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refreshRequest:++self.page];
        [self.table.mj_footer endRefreshing];
    }];

}
-(void)refreshRequest:(NSInteger)page{
   
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager posts:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"universityId"] q:self.searchStr offset:page success:^(id data) {
        if (page==1) {
            [self.dataArr removeAllObjects];
        }
        NSDictionary *dic =data;
        
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
- (IBAction)waritAction:(id)sender {
    WriteVC *vc =[[WriteVC alloc] init];
    [self  presentViewController:vc animated:YES completion:nil];
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
    self.searchStr = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.table.mj_header beginRefreshing];
}
#pragma mark -tableviewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"WateringCell";
    WateringCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell setData:self.dataArr[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
