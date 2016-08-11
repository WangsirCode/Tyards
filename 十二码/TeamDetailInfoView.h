//
//  TeamDetailInfoView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
#import "OvalView.h"
#import "RecordLabel.h"
/*!
 *  @author 汪宇豪, 16-08-09 14:08:50
 *
 *  @brief 球队详情页的view
 */
@interface TeamDetailInfoView : UIView
@property (nonatomic,strong)UILabel* infoLabel;
@property (nonatomic,strong)UILabel* recordLabel;
@property (nonatomic,strong)UILabel* honorLabel;
@property (nonatomic,strong)UIImageView* logoImageView;
@property (nonatomic,strong)UILabel* nameLabel;
@property (nonatomic,strong)UILabel* playerLabel;
@property (nonatomic,strong)UILabel* detailLabel;
@property (nonatomic, strong)TeamInfoModel  *model;
@property (nonatomic,strong)UIButton* allButton;
@property (nonatomic,strong)OvalView* ovalView;
@property (nonatomic,strong)UIImageView* recordImageView;
@property (nonatomic,strong)RecordLabel* winlabel;
@property (nonatomic,strong)RecordLabel* dragLabel;
@property (nonatomic,strong)RecordLabel* loseLabel;

@end
