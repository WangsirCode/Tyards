//
//  ImageContainerView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZPhotoBrowser.h"
#import "MDABizManager.h"
/*!
 *  @author 汪宇豪, 16-09-13 10:09:15
 *
 *  @brief 用于展示评论中图片的view
 */
@interface ImageContainerView : UIView<HZPhotoBrowserDelegate>
@property (nonatomic,strong) NSArray<NSString*> *model;
@end
