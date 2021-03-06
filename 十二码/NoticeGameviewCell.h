//
//  NoticeGameviewCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
#import "NoticeCellView.h"
/*!
 *  @author 汪宇豪, 16-07-27 14:07:08
 *
 *  @brief 比赛预告的cell
 */
@class NoticeCellView;
@interface NoticeGameviewCell : UITableViewCell
@property (nonatomic,strong) NoticeCellView * view;
@property (nonatomic,strong) Games          * model;
@end
