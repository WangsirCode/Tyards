//
//  TournamentPolicyResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/19.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class PolicyModel,Tournament,Logo;
@interface TournamentPolicyResponseModel : NSObject

@property (nonatomic, strong) PolicyModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface PolicyModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *text;


@end




