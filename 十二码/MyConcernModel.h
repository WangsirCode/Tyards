//
//  MyConcernModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
#import "TeamHomeModelResponse.h"
@class ConcernModel,User,Avatar,Player;
@interface MyConcernModel : NSObject


@property (nonatomic, strong) NSArray<ConcernModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end

@interface Coach : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Avatar *avatar;


@end
@interface Tournament : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;


@end


@interface ConcernModel : NSObject

@property (nonatomic, assign) long long date;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Player *player;

@property (nonatomic, strong) User *user;

@property (nonatomic,strong)Team* team;

@property (nonatomic,strong)Tournament* tournament;

@property (nonatomic,strong)Coach* coach;
@end


@interface User : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *avatar;

@end

