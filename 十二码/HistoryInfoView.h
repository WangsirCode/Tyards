//
//  HistoryInfoView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
/*!
 *  @author 汪宇豪, 16-09-09 11:09:16
 *
 *  @brief 显示历史交锋信息的view
 */
@interface HistoryInfoView : UIView
//@property (nonatomic,strong) UILabel* titleLabel;
//@property (nonatomic,strong) UILabel* roundLabel;
@property (nonatomic,strong) UIImageView* homeImageview;
@property (nonatomic,strong) UIImageView* awayImgaeview;
@property (nonatomic,strong) UILabel* homeLabel;
//@property (nonatomic,strong) UILabel* statusLabel;
@property (nonatomic,strong) UILabel* homeScoreLabel;
@property (nonatomic,strong) UILabel* awaySocreLabel;
@property (nonatomic,strong) UILabel* centerLabel;
@property (nonatomic,strong) UILabel* homeTitleLabel;
@property (nonatomic,strong) UILabel* awayTitleLabel;
@property (nonatomic,strong) PlayHistory* model;
@property (nonatomic,strong) UIImageView* locationImageView;
@property (nonatomic,strong) UIImageView* timeImageView;
@property (nonatomic,strong) UILabel *timeLabel;
//@property (nonatomic,assign)NSInteger status;
//@property (nonatomic,assign)NSInteger location;

@end
