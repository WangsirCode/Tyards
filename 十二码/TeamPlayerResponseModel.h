//
//  TeamPlayerResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HomeCell.h"

@class TeamPlayerModel,Player,Avatar,Team1,TeamPlayerModel1,Coaches;
@class Coach,Avatar,Team,Logo;
@interface TeamPlayerResponseModel : NSObject

@property (nonatomic, strong)TeamPlayerModel1 *resp;

@property (nonatomic, assign) NSInteger code;

@end

@interface TeamPlayerModel1 : NSObject

@property (nonatomic,strong) NSArray<TeamPlayerModel*> *players;

@property (nonatomic,strong) NSArray<Coaches*> *coaches;

@property (nonatomic,strong) TeamPlayerModel* captain;


@end
@interface TeamPlayerModel : NSObject

@property (nonatomic, strong) Player *player;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *retireDate;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL retire;

@property (nonatomic, strong) Team1 *team;

@property (nonatomic, assign) long long joinDate;

@end

@interface Player : NSObject

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, strong) Avatar *avatar;

@end

@interface Avatar : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *type;

@end

@interface Team1 : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *logo;

@end

@interface Coaches : NSObject
@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long joinDate;

@property (nonatomic, strong) Coach *coach;

@property (nonatomic, strong) Team1 *team;

@property (nonatomic, assign) BOOL retire;

@property (nonatomic, copy) NSString *retireDate;

@end

