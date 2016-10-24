//
//  StartUpModel.h
//  十二码
//
//  Created by Hello World on 16/10/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MDABizManager.h"
@class StartSubModel;
@interface StartUpModel : NSObject

@property (nonatomic, strong) StartSubModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface StartSubModel : NSObject
@property (nonatomic, strong) NSString *url;

@end
