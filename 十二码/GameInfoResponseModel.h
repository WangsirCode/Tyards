//
//  GameInfoResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class GameInfoModel,Rounds,University;
@interface GameInfoResponseModel : NSObject

@property (nonatomic, strong) GameInfoModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface GameInfoModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) NSInteger teamSize;

@property (nonatomic, copy) NSString *matchType;

@property (nonatomic, strong) Area *area;

@property (nonatomic, copy) NSString *sponsor;

@property (nonatomic, copy) NSString *college;

@property (nonatomic, strong) Logo *logo;

@property (nonatomic, copy) NSString *host;

@property (nonatomic, strong) University *university;

@property (nonatomic, strong) NSArray<Rounds *> *rounds;

@property (nonatomic, assign) BOOL fan;

@property (nonatomic, assign) BOOL complete;

@property (nonatomic, assign) long long startDate;

@property (nonatomic, assign) long long completeDate;

@property (nonatomic, copy) NSString *name;

@end



@interface Rounds : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

