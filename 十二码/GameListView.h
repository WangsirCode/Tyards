//
//  GameListView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomView.h"
/*!
 *  @author 汪宇豪, 16-08-03 20:08:21
 *
 *  @brief 赛事一览中的view
 */
@interface GameListView : UIView
@property (nonatomic,strong) UIImageView * logoImageView;
@property (nonatomic,strong) UILabel     * titleLabel;
@property (nonatomic,strong) UILabel     * timeLabel;
@property (nonatomic,strong) CostomView  * locationView;
@property (nonatomic,strong) UILabel     * statusLabel;
@property (nonatomic,assign) NSInteger   status;
@property (nonatomic,strong) NSString* location;
@end
