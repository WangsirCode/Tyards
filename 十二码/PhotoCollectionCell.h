//
//  PhotoCollectionCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"

/*!
 *  @author 汪宇豪, 16-08-09 09:08:41
 *
 *  @brief 相册页面的cell
 */
@interface PhotoCollectionCell : UICollectionViewCell
@property (nonatomic, strong) TeamAlbumModel *model;
@property (nonatomic,strong ) UILabel        * titleLabel;
@property (nonatomic,strong ) UILabel        * numberLabel;
@property (nonatomic,strong ) UIImageView    * imageView;
@end
