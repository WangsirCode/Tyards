//
//  GenderPickerView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GenderPickerViewDelegate
- (void)GenderPickerViewDidClickDoneButton;
- (void)GenderPickerViewDidClickCancelButton;
@end
@interface GenderPickerView : UIView
@property (nonatomic,strong) UIPickerView* pickerView;
@property (nonatomic,strong) UIButton* doneButton;
@property (nonatomic,strong) UIButton* cancalButton;
@property (nonatomic,strong) id<GenderPickerViewDelegate> genderDelegate;
@end
