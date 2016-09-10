//
//  CenterAlertIView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CenterAlertIView;
@protocol CenterAlertIViewDelegate
- (void)didClickDoneButton:(CenterAlertIView*)view index:(NSInteger)selectedIndex;
@end
@interface CenterAlertIView : UIView
@property (nonatomic,strong) UIView* maskView;
@property (nonatomic,strong) UIPickerView* pickerView;
@property (nonatomic,strong) UIButton* doneButton;
@property (nonatomic,strong) id<CenterAlertIViewDelegate> delegate;
@end
