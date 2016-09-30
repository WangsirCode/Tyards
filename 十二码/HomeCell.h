//
//  HomeCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
#import "MDABizManager.h"
@interface HomeCell : UITableViewCell
@property (nonatomic,strong) UILabel     * titleLabel;
@property (nonatomic,strong) UIImageView * newsImage;
@property (nonatomic,strong) UILabel     * inifoLabel;
@property (nonatomic,strong) UILabel     * commentLabel;
@property (nonatomic,strong) UIImageView * conmmentView;
@property (nonatomic,strong) BottomView* bottomview;
@property (nonatomic,strong) News *model;
@end
