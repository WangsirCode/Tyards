//
//  GameNewsDetailResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/11.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@interface GameNewsDetailResponseModel : NSObject
@property (nonatomic, strong) NSArray<News *> *resp;

@property (nonatomic, assign) NSInteger code;
@end
