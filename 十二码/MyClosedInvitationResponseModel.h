//
//  MyClosedInvitationResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class InvitationModel;
@interface MyClosedInvitationResponseModel : NSObject

@property (nonatomic, strong) NSArray<InvitationModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
