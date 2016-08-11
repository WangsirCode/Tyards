//
//  ScheduleResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ScheduleResponseModel.h"

@implementation ScheduleResponseModel

@end
@implementation ScheduleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"latestsrounds" : [Latestsrounds class], @"allrounds" : [Allrounds class]};
}

@end


@implementation Latestsrounds

+ (NSDictionary *)objectClassInArray{
    return @{@"games" : [Games class]};
}

@end

@implementation Allrounds

@end


@implementation LatestNews

MJCodingImplementation
@end