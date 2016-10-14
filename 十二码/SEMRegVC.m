//
//  SEMRegVC.m
//  十二码
//
//  Created by Hello World on 16/10/12.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMRegVC.h"
#import "SEMNetworkingManager.h"

@interface SEMRegVC ()
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
@property (weak, nonatomic) IBOutlet UITextField *accTF;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@end

@implementation SEMRegVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    self.regBtn.layer.borderWidth=1;
}

- (IBAction)regAction:(id)sender {
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager reg:self.accTF.text nickname:self.nicknameTF.text password:self.passTF.text success:^(id data) {
        [self dismissViewControllerAnimated:YES completion:nil];

    } failure:^(NSError *aError) {
        NSLog(@"%@",aError);
    }];
//    [manager reg:<#(NSString *)#> nickname:<#(NSString *)#> password:<#(NSString *)#> success:<#^(id data)successBlock#> failure:<#^(NSError *aError)failureBlock#> success:^(id data) {
//        self.datasource = data;
//        [subscriber sendNext:@1];
//        self.index += 1;
//        if (self.index == 2) {
//            [subscriber sendCompleted];
//        }
//        [DataArchive archiveData:self.datasource withFileName:newscash];
//    } failure:^(NSError *aError) {
//        NSLog(@"%@",aError);
//    }];
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
