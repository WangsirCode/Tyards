//
//  AlbumDetailResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class AlbumModel,Medias,Media,News;
@interface AlbumDetailResponseModel : NSObject

@property (nonatomic, strong) AlbumModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface AlbumModel : NSObject

@property (nonatomic, strong) NSArray<Medias *> *medias;

@property (nonatomic, assign) NSInteger total;

@end




