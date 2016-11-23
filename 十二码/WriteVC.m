//
//  WriteVC.m
//  十二码
//
//  Created by Hello World on 16/11/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "WriteVC.h"
#import "UIPlaceHolderTextView.h"
#import "MDABizManager.h"
#import "SEMViewModel.h"

#define MARGIN 20.0

@interface WriteVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewPadding;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/**
 * 照片数组 ->用于管理
 * 1. 上传到服务器时需要
 * 2. 添加新的照片时需要
 * 3. 删除已在文中的照片时需要
 */
@property (nonatomic, strong) NSMutableArray  *photos;

/**
 * 索引数组 －>编辑时记录图片location
 * 1. 添加图片时，要记录该图片的location
 * 2. 删除图片时，通过location与该数组判断得出删除的是哪张照片
 */
@property (nonatomic, strong) NSMutableArray *locations;

@end

@implementation WriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos=[NSMutableArray array];
    self.locations=[NSMutableArray array];
    if (self.postId) {
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager post:self.postId success:^(id data) {
            NSDictionary *dic =data;
            if ([dic[@"code"] integerValue]==0) {
                NSDictionary *dataDic =dic[@"resp"];
                self.titleTF.text=dataDic[@"title"];
                self.textView.attributedText=[self htmlAttributeStringByHtmlString:dataDic[@"text"]];
            }
        } failure:^(NSError *aError) {
            
        }];
    }else{
        self.postId=@"";
        self.textView.placeholder=@"请输入正文";
    }
}

- (IBAction)closeAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否保存草稿？" message:nil delegate:self cancelButtonTitle:@"不保存" otherButtonTitles:@"保存", nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSString *token=(NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager updateDraft:token title:self.titleTF.text content:[self htmlStringByHtmlAttributeString:self.textView.attributedText] university:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"universityId"] draft:YES draftId:self.postId success:^(NSInteger data) {
            if (data==0) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } failure:^(NSError *aError) {
            
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}


- (IBAction)releaseAction:(id)sender {
    NSString *token=(NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager addPost:token title:self.titleTF.text content:[self htmlStringByHtmlAttributeString:self.textView.attributedText] university:(NSString*)[DataArchive unarchiveUserDataWithFileName:@"universityId"] success:^(NSInteger data) {
        if (data==0) {
            [XHToast showCenterWithText:@"发表成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *aError) {
        
    }];
}
- (IBAction)sendPicAction:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    
    [sheet showInView:self.view];
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"location:%d,length:%d",(int)range.location, (int)range.length);
    // 模拟点击回车发送资料到服务器
    if ([text isEqualToString:@"\n"]) {
        // 提交到服务器
//        [self postToServer];
    }
    
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.bottomView.hidden=NO;

}
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.bottomView.hidden=YES;

}
- (void)textViewDidChange:(UITextView *)textView{
    self.titleLab.text=[NSString stringWithFormat:@"%lu字",(unsigned long)textView.text.length];
}

#pragma mark--UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController*   pickerController= [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = YES;
            pickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
            pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
            [self presentViewController:pickerController animated:YES completion:nil];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                           message:@"您的设备没有照相机"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }
    if (buttonIndex == 1) {
        UIImagePickerController *pickerController= [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
        [self setAttributeStringWithImage:image];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/** 将图片插入到富文本中*/
- (void)setAttributeStringWithImage:(UIImage *)image{
    // 1. 保存图片与图片的location
    [self.photos addObject:image];
    [self.locations addObject:@(self.textView.selectedRange.location)];
    
    // 2. 将图片插入到富文本中
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    CGFloat imageRate = image.size.width / image.size.height;
    attach.bounds = CGRectMake(0, 10, self.textView.frame.size.width - MARGIN, (self.textView.frame.size.width - MARGIN) / imageRate);
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attach];
    //    [mutableAttr replaceCharactersInRange:range withAttributedString:imageAttr];
    NSMutableAttributedString *mutableAttr = [self.textView.attributedText mutableCopy];
    [mutableAttr insertAttributedString:imageAttr atIndex:self.textView.selectedRange.location];
    self.textView.attributedText = mutableAttr;
}
/** 将富文本格式化为超文本*/
- (NSString *)htmlStringByHtmlAttributeString:(NSAttributedString *)htmlAttributeString{
    NSString *htmlString;
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    
    NSData *htmlData = [htmlAttributeString dataFromRange:NSMakeRange(0, htmlAttributeString.length) documentAttributes:exportParams error:nil];
    htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    return htmlString;
}
/** 将超文本格式化为富文本*/
- (NSAttributedString *)htmlAttributeStringByHtmlString:(NSString *)htmlString{
    NSAttributedString *attributeString;
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *importParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSError *error = nil;
    attributeString = [[NSAttributedString alloc] initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
    return attributeString;
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
