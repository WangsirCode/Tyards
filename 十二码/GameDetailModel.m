//
//  GameDetailModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameDetailModel.h"

@implementation GameDetailResponseModel

+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [GameDetailModel class]};
}
MJCodingImplementation
@end


@implementation GameDetailModel
MJCodingImplementation
@end


@implementation Group
MJCodingImplementation
@end


@implementation Home
MJCodingImplementation
@end


@implementation Stadium
MJCodingImplementation
@end


@implementation Round
MJCodingImplementation
@end


@implementation Away
MJCodingImplementation
@end


@implementation Tournament
+ (NSDictionary *)objectClassInArray{
    return @{@"logo" : [Logo class]};
}
MJCodingImplementation
@end



