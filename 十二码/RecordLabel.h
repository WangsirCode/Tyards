//
//  RecordLabel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
/*!
 *  @author 汪宇豪, 16-08-09 17:08:32
 *
 *  @brief 显示战绩的label
 */
@interface RecordLabel : UIView
@property (nonatomic,assign) NSInteger   mark;
@property (nonatomic,strong) Record      * model;
@property (nonatomic,strong) UIImageView * markView;
@property (nonatomic,strong) UILabel     * statusLable;
@property (nonatomic,strong) UILabel     * numLabel;
@property (nonatomic,strong) UILabel     * percentageLabel;
- (instancetype)initWithMark:(NSInteger)mark;
@end
