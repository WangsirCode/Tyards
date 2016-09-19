//
//  GameDetailModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameDetailModel.h"

@implementation GameDetailResponseModel
MJCodingImplementation

+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [GameDetailModel class]};
}
@end





@implementation GameDetailModel
MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"games" : [Games class]};
}
-(NSString *)getDate1
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.date/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年MM月dd日";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end

@implementation Games
MJCodingImplementation
-(NSInteger)getStatus1
{
    if([self.status isEqualToString:@"PLANNING"])
    {
        return 2;
    }
    else if ([self.status isEqualToString:@"PLAYING"])
    {
        return 1;
    }
    else
    {
        return 3;
    }
}
- (NSString *)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH : mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
- (NSString *)getDate2
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH : mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
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






