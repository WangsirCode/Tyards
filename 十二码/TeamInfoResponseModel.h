//
//  TeamInfoResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
#import "TeamHomeModelResponse.h"
@class TeamInfoModel;
@class Cover;
@class Honours;
@class Team,Logo,Logo;
@class Avatar;
@interface TeamInfoResponseModel : NSObject

@property (nonatomic, strong) TeamInfoModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface Captain : NSObject


@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, strong) Avatar *avatar;


@end

@interface Record : NSObject
@property (nonatomic, assign) NSInteger draws;

@property (nonatomic, strong) NSArray<Honours*> *honours;

@property (nonatomic, assign) NSInteger wins;

@property (nonatomic, assign) NSInteger loses;
@end
@interface Info : NSObject

@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) Captain *captain;

@property (nonatomic, strong) Logo *logo;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Cover *cover;

@property (nonatomic, strong) Coach *coach;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;


@end

@interface TeamInfoModel : NSObject

@property (nonatomic, assign) BOOL fan;

@property (nonatomic, strong) Info *info;

@property (nonatomic, strong) Record *data;

@end





