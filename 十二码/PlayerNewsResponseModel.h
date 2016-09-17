//
//  PlayerNewsResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class Resp,Creator;
@interface PlayerNewsResponseModel : NSObject

@property (nonatomic, strong) NSArray<NewsDetailModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end

