//
//  StateVC.m
//  十二码
//
//  Created by Hello World on 16/9/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "StateVC.h"
#import "MDABizManager.h"

@interface StateVC ()
@property (nonatomic,strong)UIBarButtonItem* backItem;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation StateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.title=@"免责声明";
//    _textView.selectedRange = NSMakeRange(0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 25, 20);
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
