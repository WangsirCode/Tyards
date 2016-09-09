//
//  TournamentGamesResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TournamentGamesResponseModel.h"

@implementation TournamentGamesResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [TournamentGamesModel class]};
}
@end
@implementation TournamentGamesModel

+ (NSDictionary *)objectClassInArray{
    return @{@"games" : [Games class]};
}
@end


