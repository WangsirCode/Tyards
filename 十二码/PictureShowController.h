//
//  PictureShowController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MDABizManager.h"
#import <UIKit/UIKit.h>
@interface PictureShowController : UIViewController
@property(nonatomic, strong) NSArray<Medias *> *model;
@property(nonatomic, assign) NSUInteger index;
@property(nonatomic, strong) NSArray<NSString *> *ImageURLs;
- (instancetype)initWithImages:(NSArray<NSString *> *)imagesURL
                         index:(NSInteger)index;
@end
