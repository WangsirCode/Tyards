//
//  PlayerNewsResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerNewsResponseModel.h"

@implementation PlayerNewsResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [NewsDetailModel class]};
}
@end

