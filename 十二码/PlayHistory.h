//
//  PlayHistory.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@interface PlayHistory : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger penaltyHome;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger homeScore;

@property (nonatomic, strong) Tournament *tournament;

@property (nonatomic, assign) long long playDate;

@property (nonatomic, strong) Away *away;

@property (nonatomic, assign) BOOL giveupAway;

@property (nonatomic, strong) Home *home;

@property (nonatomic, strong) Stadium *stadium;

@property (nonatomic, copy) NSString *latestNews;

@property (nonatomic, assign) NSInteger penaltyAway;

@property (nonatomic, strong) Round *round;

@property (nonatomic, assign) NSInteger awayScore;

@property (nonatomic, copy) NSString *status;

- (NSString*)getDate;

- (NSString*)getScore;
@end