//
//  MeTopView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeinfoVIew.h"
/*!
 *  @author 汪宇豪, 16-07-26 09:07:54
 *
 *  @brief 个人信息页顶部的view
 */
@interface MeTopView : UIView

@property (nonatomic,strong)UIImageView* backImageView;
@property (nonatomic,strong)UIImageView* userHeadView;
@property (nonatomic,strong)UILabel* nameLabel;
@property (nonatomic,strong)MeinfoVIew* infoView;
@property (nonatomic,strong)UIImage* headImage;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)UIImageView* userHeadBackView;
@end
