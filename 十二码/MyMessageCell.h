//
//  MyMessageCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@interface MyMessageCell : UITableViewCell
@property (nonatomic,strong)UIImageView* logoImageView;
@property (nonatomic,strong)UILabel* label;
@property (nonatomic,strong)UILabel* detailLabel;
@property (nonatomic,strong)UILabel* dateLabel;
@property (nonatomic, strong) Reply *model;
@end
