//
//  InfoViewCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@class BottomButton;
@interface InfoViewCell : UITableViewCell
@property (nonatomic,strong) UILabel* label;
@property (nonatomic,strong) UIView* bottomView;
@property (nonatomic,strong)BottomButton* heightButton;
@property (nonatomic,strong)BottomButton* weightButton;
@property (nonatomic,strong)BottomButton* positionButton;
@property (nonatomic, strong)PlayerDetail *model;
@end

@interface BottomButton : UIView
@property (nonatomic,strong)UILabel* infoLabel;
@property (nonatomic,strong)UILabel* dataLabel;
@end