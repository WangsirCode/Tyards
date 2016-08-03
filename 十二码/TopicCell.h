//
//  TopicCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
#import "BottomView.h"
/*!
 *  @author 汪宇豪, 16-07-27 09:07:13
 *
 *  @brief 显示话题的cell
 */
@interface TopicCell : UITableViewCell
@property (nonatomic,strong)BottomView* bottomView;
@property (nonatomic,strong)UIImageView* titleImageView;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,assign)CGFloat scale;
@property (nonatomic,strong)NSString* title;
@property (nonatomic,strong)NSString* titleImageURL;
@property (nonatomic,strong)NSString* info;
@property (nonatomic,strong)NSString* comment;
@end
