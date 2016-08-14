//
//  PlayerDataResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class PlayerDataModel,Avatar,Honours,Player,Avatar,Tournament,University,Shortcut,Logo,Logo,Area,Universities,Shortcut,Logo,History,Player,Avatar,Team,Logo,PlayerDetail;
@interface PlayerDataResponseModel : NSObject

@property (nonatomic, strong) PlayerDataModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface PlayerDataModel : NSObject

@property (nonatomic, strong) PlayerDetail *data;

@property (nonatomic, strong) NSArray<Honours *> *honours;

@property (nonatomic, assign) BOOL fan;

@property (nonatomic, strong) NSArray<History *> *history;

@end

@interface Honours : NSObject

@property (nonatomic, copy) NSString *owner;

@property (nonatomic, strong) Player *player;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Tournament *tournament;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *logo;

- (NSString*)honorInfo;
@end

@interface History : NSObject

@property (nonatomic, strong) Player *player;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, assign) long long retireDate;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL retire;

@property (nonatomic, strong) Team *team;

@property (nonatomic, assign) long long joinDate;

- (NSString*)timeInfo;

- (NSString*)teamInfo;
@end




