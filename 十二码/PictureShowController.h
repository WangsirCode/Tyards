//
//  PictureShowController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@interface PictureShowController : UIViewController
@property (nonatomic, strong) NSArray<Medias *> *model;
@property (nonatomic,assign) NSUInteger index;
@end
