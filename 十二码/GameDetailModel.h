//
//  GameDetailModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
//GameDetailModel
#import <Foundation/Foundation.h>
#import "MDABizManager.h"
#import "SearchModel.h"



@class GameDetailModel,Games,Group,Home,Logo,Stadium,Round,Away,Tournament,Logo;
@interface GameDetailResponseModel : NSObject<NSCoding>
@property (nonatomic, strong) NSArray<GameDetailModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end




@interface GameDetailModel : NSObject<NSCoding>

@property (nonatomic, assign) long long date;

@property (nonatomic, strong) NSArray<Games *> *games;
- (NSString*)getDate1;
@end

@interface Games : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger penaltyHome;

@property (nonatomic, copy) NSString *description1;

@property (nonatomic, assign) NSInteger homeScore;

@property (nonatomic, strong) Tournament *tournament;

@property (nonatomic, assign) long long playDate;

@property (nonatomic, strong) Away *away;

@property (nonatomic, assign) BOOL giveupAway;

@property (nonatomic, strong) Group *group;

@property (nonatomic, strong) Home *home;

@property (nonatomic, strong) Stadium *stadium;

@property (nonatomic, copy) NSString *latestNews;

@property (nonatomic, assign) NSInteger penaltyAway;

@property (nonatomic, strong) Round *round;

@property (nonatomic, assign) NSInteger awayScore;

@property (nonatomic, copy) NSString *status;

- (NSInteger)getStatus1;

@end

@interface Group : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

@interface Home : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end



@interface Stadium : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

@interface Round : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

@interface Away : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *logo;

@end



