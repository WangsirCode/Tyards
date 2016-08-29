//
//  PlayerDataResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerDataResponseModel.h"

@implementation PlayerDataResponseModel

@end

@implementation CoachDataResponseModel

@end

@implementation PlayerDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"honours" : [Honours class], @"history" : [History class]};
}

@end


@implementation CoachDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"honours" : [Honours class], @"history" : [History class]};
}

@end

@implementation Honours
- (NSString *)honorInfo
{
    NSMutableString* string = [[NSMutableString alloc] init];
    [string appendString:[NSString stringWithFormat:@"%ld年",(long)self.year]];
    [string appendString:self.tournament.name];
    [string appendString:self.name];
    return string;
}
@end






@implementation History
- (NSString *)timeInfo
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.joinDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年";
    NSString* ta = [formater stringFromDate:date];
    NSMutableString* stirng = [NSMutableString stringWithString:ta];
    [stirng appendString:@" - "];
    if (self.retireDate) {
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.retireDate/1000];
        NSString* taa = [formater stringFromDate:date];
        [stirng appendString:taa];
    }
    else
    {
        [stirng appendString:@"至今"];
    }
    return stirng;
}

- (NSString *)teamInfo
{
    return self.team.name;
}
@end





