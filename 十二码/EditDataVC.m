//
//  EditDataVC.m
//  十二码
//
//  Created by Hello World on 16/11/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "EditDataVC.h"
#import "UIPlaceHolderTextView.h"
#import "MDABizManager.h"
#import "ChangeNickNameController.h"
#import "SEMSearchViewController.h"
#import "ColleageSearchController.h"
@interface EditDataVC ()
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
@property (nonatomic,strong) UIBarButtonItem       * backItem;

@end

@implementation EditDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑资料";
    self.textView.placeholder=@"写点什么介绍下自己吧";
    self.navigationItem.leftBarButtonItem = self.backItem;

}

- (IBAction)headImgAction:(id)sender {
}
- (IBAction)nicknameAction:(id)sender {
    ChangeNickNameController *vc =[[ChangeNickNameController alloc] initWithDictionary:@{@"name":@""}];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)schoolAction:(id)sender {
//    SEMSearchViewController* searchControlle = [HRTRouter objectForURL:@"search" withUserInfo:@{}];
//    searchControlle.delegate = self;
//    [self.navigationController pushViewController:searchControlle animated:true];
}
- (IBAction)collegeAction:(id)sender {
//    if (self.viewModel.model.university.id == 0) {
//        [XHToast showCenterWithText:@"请选择学校"];
//    }
//    else
//    {
//        ColleageSearchController* searchControlle = [HRTRouter objectForURL:@"MEInfoColleageSearch" withUserInfo:@{@"code":@(self.viewModel.model.university.id)}];
//        searchControlle.delegate = self;
//        [self.navigationController pushViewController:searchControlle animated:true];
//    }
}
- (IBAction)timeAction:(id)sender {
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
