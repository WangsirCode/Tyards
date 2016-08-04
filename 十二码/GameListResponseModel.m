//
//  GameListResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameListResponseModel.h"

@implementation GameListResponseModel

MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [GameListModel class]};
}
@end
@implementation GameListModel
MJCodingImplementation
-(NSInteger)getStatus
{
    NSDate* date = [[NSDate alloc] init];;
    NSDate *startdate = [[NSDate alloc]initWithTimeIntervalSince1970:self.startDate/1000];
    NSComparisonResult result = [date compare:startdate];
    if (self.complete == YES) {
        return 3;
    }
    //还没开始
    else if(result == NSOrderedAscending)
    {
        return 2;
    }
    //开始了
    else
    {
        return 1;
    }
}
-(NSString *)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.startDate/1000];
    NSDate* end = [[NSDate alloc]initWithTimeIntervalSince1970:self.completeDate/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy年MM月dd日";
    NSString* ta = [formater stringFromDate:date];
    NSString* taa = [formater stringFromDate:end];
    NSMutableString* stirng = [NSMutableString stringWithString:ta];
    [stirng appendString:@" - "];
    [stirng appendString:taa];
    return stirng;
}
- (NSString *)getLocation
{
//    NSMutableString* string;
//    if (self.area) {
//        string = [NSMutableString stringWithString:self.area.name];
//        [string appendString:@"赛区"];
//        return string;
//    }
//    else
//    {
//        string = [NSMutableString stringWithString:self.university.displayName];
//        return string;
//    }
    return @"湖北赛区";
    
}
@end


@implementation University
MJCodingImplementation

@end






