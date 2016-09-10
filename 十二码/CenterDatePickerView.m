//
//  CenterDatePickerView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CenterDatePickerView.h"

@implementation CenterDatePickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sd_addSubviews:@[self.maskView,self.pickerView,self.doneButton,self.cancelButton]];
        self.userInteractionEnabled =YES;
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(300*self.scale));
            make.height.equalTo(@(250*self.scale));
        }];
            [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.pickerView.mas_bottom).offset(-5*self.scale);
                make.right.equalTo(self.pickerView.mas_right).offset(-10*self.scale);
                make.height.equalTo(@(30*self.scale));
                make.width.equalTo(@(40*self.scale));
            }];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self removeFromSuperview];
        }];
        [self.maskView addGestureRecognizer:tap];
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
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor MyColor] forState:UIControlStateNormal];
        //        [[_doneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //            [self.delegate didClickDoneButton:self];
        //        }];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.userInteractionEnabled = YES;
    }
    return _doneButton;
}
- (void)buttonClick
{
    [self.delegate didClickDoneButton:self];
}
- (void)cancelButtonClick
{
    [self removeFromSuperview];
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
- (UIDatePicker *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.userInteractionEnabled = YES;
    }
    return _pickerView;
}
@end
