//
//  PlayerInforesponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class PlayerModel,PlayerDetail,Newses,Articles,Cover,CoachModel;
@interface PlayerInforesponseModel : NSObject

@property (nonatomic, strong) PlayerModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface CoachInfoResponseModel : NSObject

@property (nonatomic, strong) CoachModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface PlayerModel : NSObject

@property (nonatomic, strong) PlayerDetail *player;

@property (nonatomic, strong) NSArray<Newses *> *newses;

@property (nonatomic, strong) NSArray<Articles *> *articles;

@end
@interface CoachModel : NSObject

@property (nonatomic, strong) PlayerDetail *coach;

@property (nonatomic, strong) NSArray<Newses *> *newses;

@property (nonatomic, strong) NSArray<Articles *> *articles;

@end
@interface PlayerDetail : NSObject

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, strong) Avatar *avatar;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) Cover *cover;

@property (nonatomic, copy) NSString *name;

- (NSString*)heightInfo;
- (NSString*)weightInfo;
- (NSString*)PosionInfo;
@end

@interface CoachDetail : NSObject

@end
