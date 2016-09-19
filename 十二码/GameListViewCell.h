//
//  GameListViewCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameListView.h"
/*!
 *  @author 汪宇豪, 16-07-27 14:07:45
 *
 *  @brief 赛事一览的cell
 */
@interface GameListViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * logoImageView;
@property (nonatomic,strong) UILabel     * titleLabel;
@property (nonatomic,strong) UILabel     * timeLabel;
@property (nonatomic,strong) CostomView  * locationView;
@property (nonatomic,strong) UILabel     * statusLabel;
@property (nonatomic,strong) UILabel* locationLabel;
@property (nonatomic,assign) NSInteger   status;
@property (nonatomic,strong) NSString* location;
@end
