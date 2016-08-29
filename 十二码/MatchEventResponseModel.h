//
//  MatchEventResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class MetchEventModel,Events,Player;
@interface MatchEventResponseModel : NSObject

@property (nonatomic, strong) MetchEventModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface MetchEventModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSArray<Events *> *events;

@end

@interface Events : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL home;

@property (nonatomic, strong) Player *player;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger minute;

@end


