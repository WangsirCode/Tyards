//
//  ScorerListResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class ScorerListModel,Player,Team;
@interface ScorerListResponseModel : NSObject

@property (nonatomic, strong) NSArray<ScorerListModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface ScorerListModel : NSObject

@property (nonatomic, strong) Player *player;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) Team *team;

@end



