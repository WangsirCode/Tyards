//
//  GameMessageResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/11.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameMessageResponseModel.h"

@implementation GameMessageResponseModel
+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [NewsDetailModel class]};
}
@end
