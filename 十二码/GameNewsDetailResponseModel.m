//
//  GameNewsDetailResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/11.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameNewsDetailResponseModel.h"

@implementation GameNewsDetailResponseModel
+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [News class]};
}
@end
