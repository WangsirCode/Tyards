//
//  CenterDatePickerView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@class CenterDatePickerView;
@protocol CenterDatePickerViewDelegate
- (void)didClickDoneButton:(CenterDatePickerView*)view;
- (void)didClickCancelButton:(CenterDatePickerView*)view;
@end
@interface CenterDatePickerView : UIView
@property (nonatomic,strong) UIView       * maskView;
@property (nonatomic,strong) UIDatePicker * pickerView;
@property (nonatomic,strong) UIButton     * doneButton;
@property (nonatomic,strong) UIButton     * cancelButton;
@property (nonatomic,strong) id<CenterDatePickerViewDelegate> delegate;
@end

