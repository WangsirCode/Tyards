//
//  CenterAlertIView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CenterAlertIView.h"
#import "MDABizManager.h"
@implementation CenterAlertIView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sd_addSubviews:@[self.maskView,self.pickerView,self.doneButton]];
        self.userInteractionEnabled =YES;
        self.pickerView.sd_layout
        .centerXEqualToView(self)
        .centerYEqualToView(self)
        .widthIs(300*self.scale)
        .heightIs(250*self.scale);
        self.doneButton.sd_layout
        .rightSpaceToView(self,45*self.scale)
        .bottomSpaceToView(self,215*self.scale)
        .heightIs(30*self.scale)
        .widthIs(40*self.scale);
    }
    return self;
}
- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"确认" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor MyColor] forState:UIControlStateNormal];
//        [[_doneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            [self.delegate didClickDoneButton:self];
//        }];
        [_doneButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _doneButton.userInteractionEnabled = YES;
    }
    return _doneButton;
}
- (void)buttonClick
{
    [self.delegate didClickDoneButton:self index:[self.pickerView selectedRowInComponent:0]];
}
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.frame = [UIScreen mainScreen].bounds;
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.6;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.userInteractionEnabled = YES;
    }
    return _pickerView;
}
@end
