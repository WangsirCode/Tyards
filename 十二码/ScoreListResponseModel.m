//
//  ScoreListResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ScoreListResponseModel.h"

@implementation ScoreListResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [ScoreListModel class]};
}
@end
@implementation ScoreListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"grids" : [Grids class]};
}

@end


@implementation Grids
- (NSInteger)getNum
{
    return self.loses + self.wins + self.draws;
}
@end

