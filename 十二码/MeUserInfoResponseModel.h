//
//  MeUserInfoResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
#import "GameListResponseModel.h"
@class UserInfoModel,College,Favteam;
@interface MeUserInfoResponseModel : NSObject

@property (nonatomic, strong) UserInfoModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, strong) Universities *university;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<Favteam *> *favTeam;

@property (nonatomic, strong) College *college;

@property (nonatomic, assign) long long birthDay;
- (NSString*)getMyBirthday;
@end



@interface Favteam : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *team;

@end
@interface CollegeModel : NSObject
@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong)NSArray* resp;
@end
@interface College : NSObject<NSCoding>
@property (nonatomic, assign) NSInteger id;
@property (nonatomic,strong) NSString* name;
@end
