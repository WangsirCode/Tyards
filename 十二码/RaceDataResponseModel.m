//
//  RaceDataResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "RaceDataResponseModel.h"

@implementation RaceDataResponseModel

@end
@implementation RaceDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"history" : [PlayHistory class]};
}

@end


@implementation Homedata
- (NSInteger)getNum
{
    return self.wins + self.loses + self.draws;
}
@end




@implementation Awaydata
- (NSInteger)getNum
{
    return self.wins+self.loses+self.draws;
}
@end


//
//@implementation PlayHistory
//- (NSString *)getDate
//{
//    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.playDate/1000];
//    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
//    formater.dateFormat = @"yyyy-MM-dd";
//    NSString* ta = [formater stringFromDate:date];
//    return ta;
//}
//- (NSString*)getScore
//{
//    return [NSString stringWithFormat:@"%ld : %ld",self.homeScore,self.awayScore];
//}
//@end




