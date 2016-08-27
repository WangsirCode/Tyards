//
//  ScoreListResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class ScoreListModel,Grids,Team;
@interface ScoreListResponseModel : NSObject

@property (nonatomic, strong) NSArray<ScoreListModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface ScoreListModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Grids *> *grids;

@end

@interface Grids : NSObject

@property (nonatomic, assign) NSInteger offset;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger loses;

@property (nonatomic, assign) NSInteger draws;

@property (nonatomic,assign) NSInteger points;

@property (nonatomic, strong) Team *team;

@property (nonatomic, assign) NSInteger wins;

@property (nonatomic, assign) NSInteger place;

@property (nonatomic, copy) NSString *description;

- (NSInteger)getNum;
@end


