//
//  MeUserInfoResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MeUserInfoResponseModel.h"

@implementation MeUserInfoResponseModel

@end
@implementation UserInfoModel
MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"favTeam" : [Favteam class]};
}
- (NSString *)getMyBirthday
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.birthDay/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年MM月dd日";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end

@implementation Favteam
MJCodingImplementation
@end


@implementation College

MJCodingImplementation

@end