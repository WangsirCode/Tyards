//
//  TeamResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/11.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class MatchTeamModel;
@interface TeamResponseModel : NSObject

@property (nonatomic, strong) NSArray<MatchTeamModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface MatchTeamModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end

