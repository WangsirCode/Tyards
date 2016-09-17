//
//  CommentBottomView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CommentBottomView.h"
#import "MDABizManager.h"
@implementation CommentBottomView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sd_addSubviews:@[self.imageButton,self.sendButton,self.textField]];
        [self setupview];
    }
    return self;
}
- (void)setupview
{
    self.imageButton.sd_layout
    .topSpaceToView(self,8*self.scale)
    .heightIs(30*self.scale)
    .leftSpaceToView(self,10*self.scale)
    .widthEqualToHeight();
    
    self.sendButton.sd_layout
    .topSpaceToView(self,8*self.scale)
    .heightIs(30*self.scale)
    .rightSpaceToView(self,8*self.scale)
    .widthEqualToHeight();
    
    self.textField.sd_layout
    .topSpaceToView(self,5)
    .heightIs(40*self.scale)
    .leftSpaceToView(self.imageButton,10*self.scale)
    .rightSpaceToView(self.sendButton,5);
    
    UIView* line = [UIView new];
    line.backgroundColor = [UIColor MyColor];
    [self addSubview:line];
    line.sd_layout
    .topSpaceToView(self.textField,0)
    .leftEqualToView(self.textField)
    .rightEqualToView(self.textField)
    .heightIs(1);
}
- (void)reSetView
{
    self.imageButton.sd_resetLayout
    .topSpaceToView(self,8*self.scale)
    .heightIs(30*self.scale)
    .leftSpaceToView(self,10*self.scale)
    .widthEqualToHeight();
}
- (UIButton *)imageButton
{
    if (!_imageButton) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageButton setImage:[UIImage imageNamed:@"imgae.jpg"] forState:UIControlStateNormal];
    }
    return _imageButton;
}
- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setImage:[UIImage imageNamed:@"cursor"] forState:UIControlStateDisabled];
        [_sendButton setImage:[UIImage imageNamed:@"cursor02"] forState:UIControlStateNormal];
        _sendButton.enabled = NO;
    }
    return _sendButton;
}
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor BackGroundColor];
        _textField.placeholder = @"说点什么吧";
        _textField.tintColor = [UIColor MyColor];
    }
    return _textField;
}
@end
