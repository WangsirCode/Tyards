//
//  PickerView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickerViewDelegate
- (void)didCilckDoneButton;
- (void)didCilckCancelButton;
@end
@interface PickerView : UIView
@property (nonatomic,strong) UIButton* doneButton;
@property (nonatomic,strong) UIButton* cancalButton;
@property (nonatomic,strong) UIDatePicker* datePickerView;
@property (nonatomic,strong) id<PickerViewDelegate> delegate;
@end
