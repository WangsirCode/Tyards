//
//  InvitationResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationResponseModel.h"

@implementation InvitationResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [InvitationModel class]};
}
@end
@implementation InvitationModel
- (NSString *)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年MM月dd日 HH : mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
- (NSString *)getDate1
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年MM月dd日";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
- (NSString *)getTime
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
- (NSString *)getType
{
    NSDictionary *dic = @{@"FIVE":@"5人场",@"SIX":@"6人场",@"SEVEN":@"7人场",@"EIGHT":@"8人场",@"NINE":@"9人场",@"ELEVEN":@"11人场"};
    return dic[self.type];
}
@end





