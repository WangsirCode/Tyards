//
//  GenderPickerView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GenderPickerView.h"
#import "MDABizManager.h"
@implementation GenderPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self sd_addSubviews:@[self.pickerView,self.doneButton,self.cancalButton]];
//        self.pickerView.sd_layout
//        .topEqualToView(self)
//        .leftEqualToView(self)
//        .rightEqualToView(self)
//        .bottomEqualToView(self);
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        self.cancalButton.sd_layout
        .topSpaceToView(self,5)
        .leftSpaceToView(self,5)
        .widthIs(40*self.scale)
        .heightIs(30*self.scale);
        self.doneButton.sd_layout
        .topSpaceToView(self,5)
        .rightSpaceToView(self,5)
        .widthIs(40*self.scale)
        .heightIs(30*self.scale);
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pickerView.frame = self.bounds;
}
- (UIButton *)cancalButton
{
    if (!_cancalButton) {
        _cancalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancalButton setTitle:@"取消" forState:UIControlStateNormal];
        [[_cancalButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.genderDelegate GenderPickerViewDidClickCancelButton];
        }];
        [_cancalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancalButton.userInteractionEnabled = YES;
    }
    return _cancalButton;
}
- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [[_doneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.genderDelegate GenderPickerViewDidClickDoneButton];
        }];
        _doneButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _doneButton.userInteractionEnabled = YES;
        [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _doneButton;
}
-(UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
@end
