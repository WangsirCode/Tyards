//
//  PickerView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PickerView.h"
#import "MDABizManager.h"
@implementation PickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sd_addSubviews:@[self.datePickerView,self.doneButton,self.cancalButton]];
        self.datePickerView.date = [[NSDate alloc] initWithTimeIntervalSince1970:(20*365*24*3600 + 5*24*3600)];
        [self sd_addSubviews:@[self.datePickerView,self.cancalButton,self.doneButton]];
        self.datePickerView.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .bottomEqualToView(self)
        .rightEqualToView(self);
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

- (UIButton *)cancalButton
{
    if (!_cancalButton) {
        _cancalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancalButton setTitle:@"取消" forState:UIControlStateNormal];
        [[_cancalButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate didCilckCancelButton];
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
            [self.delegate didCilckDoneButton];
        }];
        _doneButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _doneButton.userInteractionEnabled = YES;
        [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _doneButton;
}
-(UIDatePicker *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] init];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    }
    return _datePickerView;
}
@end
