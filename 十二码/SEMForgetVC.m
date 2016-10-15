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
    if (![self isValidateEmail:self.accTF.text]) {
        [XHToast showCenterWithText:@"请输入有效的邮箱账号"];
    }else{
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager forget:self.accTF.text success:^(NSInteger data)
        {
            if (!data) {
                [XHToast showCenterWithText:@"邮件已发出，注意查收"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [XHToast showCenterWithText:@"邮件发送失败"];
            }

            
        } failure:^(NSError *aError) {
            NSLog(@"%@",aError);
        }];
    }
   
}
//判断是否是有效的邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
