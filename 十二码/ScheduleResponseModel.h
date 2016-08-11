//
//  ScheduleResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class ScheduleModel,Latestsrounds,Games,Latestnews,Home,Stadium,Round,Away,Tournament,Logo,Allrounds;
@interface ScheduleResponseModel : NSObject

@property (nonatomic, strong) ScheduleModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface ScheduleModel : NSObject

@property (nonatomic, strong) NSArray<Latestsrounds *> *latestsrounds;

@property (nonatomic, strong) NSArray<Allrounds *> *allrounds;

@end

@interface Latestsrounds : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Games *> *games;

@end



@interface LatestNews : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign) long long newsDate;

@end



@interface Allrounds : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

