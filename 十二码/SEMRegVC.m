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
    if (![self isValidateEmail:self.accTF.text]) {
        [XHToast showCenterWithText:@"请输入有效的邮箱账号"];
        
    }else if (self.passTF.text.length==0){
        [XHToast showCenterWithText:@"请输入邮箱密码"];
        
    }else if(self.nicknameTF.text.length==0){
        [XHToast showCenterWithText:@"请输入昵称"];

    }else{
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager reg:self.accTF.text nickname:self.nicknameTF.text password:self.passTF.text success:^(NSInteger data)
         {
            if (!data) {
                [XHToast showCenterWithText:@"注册成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [XHToast showCenterWithText:@"注册失败"];
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
