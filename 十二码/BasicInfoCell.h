//
//  BasicInfoCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-08-14 09:08:34
 *
 *  @brief 显示基本资料的cell
 */
@interface BasicInfoCell : UITableViewCell
@property (nonatomic,strong) UILabel* label;
@property (nonatomic,strong) UIView* bottomView;
@property (nonatomic,strong) NSString* text;
@end
