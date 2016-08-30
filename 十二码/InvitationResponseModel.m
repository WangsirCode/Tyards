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
    formater.dateFormat = @"yyyy年MM月dd日 HH : mm : ss";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end





