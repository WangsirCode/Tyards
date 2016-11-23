//
//  MyArticle.m
//  十二码
//
//  Created by Hello World on 16/10/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyArticle.h"
#import "MDABizManager.h"
#import "PushArticleVC.h"
#import "DraftsVC.h"
@interface MyArticle ()
@property (nonatomic,strong) UIBarButtonItem       * backItem;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;

@end

@implementation MyArticle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的基贴";
    self.navigationItem.leftBarButtonItem = self.backItem;
}
- (IBAction)oneBtnAction:(id)sender {
    PushArticleVC *vc =[[PushArticleVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)twoBtnAction:(id)sender {
    DraftsVC *vc =[[DraftsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
