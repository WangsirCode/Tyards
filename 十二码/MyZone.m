//
//  MyZone.m
//  十二码
//
//  Created by Hello World on 16/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyZone.h"
#import "MDABizManager.h"
#import "EditDataVC.h"
#import "DraftsVC.h"
#import "WriteVC.h"
@interface MyZone ()
@property (nonatomic,strong) UIBarButtonItem       * backItem;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *oneTab;
@property (weak, nonatomic) IBOutlet UITableView *twoTab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic) NSInteger page;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation MyZone
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.dataArr=[NSMutableArray array];
    self.editBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.editBtn.layer.borderWidth=1;
    self.editBtn.layer.cornerRadius=5;
    self.editBtn.layer.masksToBounds=YES;
    [self.oneTab registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCell"];
    [self.twoTab registerNib:[UINib nibWithNibName:@"HomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCell"];
    
    self.oneTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self refreshRequest:self.page];
        [self.oneTab.mj_header endRefreshing];
    }];
    self.oneTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refreshRequest:++self.page];
        [self.oneTab.mj_footer endRefreshing];
    }];
    
    self.twoTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self refreshRequest:self.page];
        [self.twoTab.mj_header endRefreshing];
    }];
    self.twoTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refreshRequest:++self.page];
        [self.twoTab.mj_footer endRefreshing];
    }];
    
}
-(void)refreshRequest:(NSInteger)page{
    
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager activities:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"userId"] offset:page success:^(id data) {
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
    } failure:^(NSError *aError) {
        
    }];
    
}
- (IBAction)btnAction:(UIButton *)sender {
    if (sender.tag==100) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.oneTab.mj_header beginRefreshing];
        [self.oneTab reloadData];
    }else if (sender.tag==200){
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];

    }else if (sender.tag==300){
        [self.scrollView setContentOffset:CGPointMake(2*ScreenWidth, 0) animated:YES];

    }
}
- (IBAction)editAction:(id)sender {
    EditDataVC *vc =[[EditDataVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)draftAction:(id)sender {
    DraftsVC *vc =[[DraftsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)writeAction:(id)sender {
    WriteVC *vc =[[WriteVC alloc] init];
    [self  presentViewController:vc animated:YES completion:nil];
}
#pragma mark -tableviewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    News* news = self.viewModel.datasource[indexPath.row];
    HomeCell* cell = [[HomeCell alloc] init];
    //    cell.model = news;
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
