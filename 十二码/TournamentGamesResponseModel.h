//
//  TournamentGamesResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class TournamentGamesModel,Games;
@interface TournamentGamesResponseModel : NSObject

@property (nonatomic, strong) NSArray<TournamentGamesModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface TournamentGamesModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<Games *> *games;

@end

