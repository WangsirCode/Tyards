//
//  TeamLisstResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
@class TeamModel,Team,Logo1;
@interface TeamLisstResponseModel : NSObject


@property (nonatomic, strong) TeamModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface TeamModel : NSObject

@property (nonatomic, strong) NSArray<Team *> *colleges;

@property (nonatomic, strong) NSArray<Team *> *others;

@property (nonatomic, strong) NSArray<Team *> *univerisities;

@end
@interface Team : NSObject
@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end

