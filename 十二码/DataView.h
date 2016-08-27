//
//  DataView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-08-27 22:08:18
 *
 *  @brief 显示主客队战绩的view
 */
@interface DataView : UIView
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * numTitileLabel;
@property (nonatomic,strong) UILabel * winTitleLabel;
@property (nonatomic,strong) UILabel * loseTitleLabel;
@property (nonatomic,strong) UILabel * drawTitleLabel;
@property (nonatomic,strong) UILabel * winLabel;
@property (nonatomic,strong) UILabel * loseLabel;
@property (nonatomic,strong) UILabel * numLabel;
@property (nonatomic,strong) UILabel * drawLabel;
@end
