//
//  HomeHeadView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface HomeHeadView : UIView<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView* scrollView;
@property (nonatomic,strong)UIView* grayView;
@property (nonatomic,strong)UILabel* titleLabel;
@end
