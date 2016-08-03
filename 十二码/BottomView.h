//
//  BottomView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-07-24 17:07:21
 *
 *  @brief tableviewcell中底部显示信息的view
 */
@interface BottomView : UIView
@property (nonatomic,strong) UILabel     * inifoLabel;
@property (nonatomic,strong) UILabel     * commentLabel;
@property (nonatomic,strong) UIImageView * conmmentView;
@property (nonatomic,assign)CGFloat scale;
@end
