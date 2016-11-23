//
//  DraftsVC.m
//  十二码
//
//  Created by Hello World on 16/11/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "DraftsVC.h"
#import "MDABizManager.h"
#import "DraftsCell.h"
#import "WriteVC.h"

@interface DraftsVC ()
@property (nonatomic,strong) UIBarButtonItem     * backItem;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation DraftsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.title=@"草稿箱";
    self.dataArr=[NSMutableArray array];
    [self.table registerNib:[UINib nibWithNibName:@"DraftsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DraftsCell"];
    [self refreshRequest];

}


-(void)refreshRequest{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager getMyDraft:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"] university:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"universityId"] success:^(id data) {
        NSDictionary *dic =data;

        if ([dic[@"code"] integerValue]==0) {
            self.dataArr= dic[@"resp"];
            [self.table reloadData];
        }
        
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
    WriteVC *vc =[[WriteVC alloc] init];
    vc.postId=self.dataArr[indexPath.row][@"id"];
    [self  presentViewController:vc animated:YES completion:nil];
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index =indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager deleteDraft:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"] draftId:self.dataArr[indexPath.row][@"id"] success:^(id data) {
            NSDictionary *dic =data;
            
            if ([dic[@"code"] integerValue]==0) {
                [self.dataArr removeObjectAtIndex:index];
                [self.table reloadData];
                [XHToast showCenterWithText:@"删除成功"];
            }
        } failure:^(NSError *aError) {
            
        }];
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
