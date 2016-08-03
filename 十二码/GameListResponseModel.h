//
//  GameListResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEMNetworkingManager.h"
#import "SearchModel.h"
@class GameListModel,University,Shortcut,Logo,Logo,Area,Universities,Shortcut,Logo;
@interface GameListResponseModel : NSObject

@property (nonatomic, strong) NSArray<GameListModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface GameListModel : NSObject

@property (nonatomic, strong) University *university;

@property (nonatomic, strong) Area *area;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long startDate;

@property (nonatomic, assign) long long completeDate;

@property (nonatomic, copy) NSString *college;

@property (nonatomic, assign) BOOL complete;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end

@interface University : NSObject

@property (nonatomic, strong) Shortcut *shortcut;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *displayName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end








