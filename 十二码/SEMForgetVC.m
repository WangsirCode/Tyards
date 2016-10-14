//
//  SEMForgetVC.m
//  十二码
//
//  Created by Hello World on 16/10/12.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMForgetVC.h"
#import "SEMNetworkingManager.h"

@interface SEMForgetVC ()
@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation SEMForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resetBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    self.resetBtn.layer.borderWidth=1;
}
- (IBAction)resetAction:(id)sender {
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager forget:self.accTF.text success:^(id data) {
        [self dismissViewControllerAnimated:YES completion:nil];

    } failure:^(NSError *aError) {
        NSLog(@"%@",aError);
    }];
}
- (IBAction)dissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
