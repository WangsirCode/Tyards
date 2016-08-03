//
//  LoginCommand.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@interface LoginCommand : NSObject
/*!
 *  @author 汪宇豪, 16-07-28 11:07:04
 *
 *  @brief 实例
 *
 *  @return 实例
 */
+ (instancetype)sharedInstance;
@property (nonatomic,strong)RACCommand* weixinLoginedCommand;
@end
