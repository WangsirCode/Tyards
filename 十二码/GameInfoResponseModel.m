//
//  GameInfoResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameInfoResponseModel.h"

@implementation GameInfoResponseModel

@end
@implementation GameInfoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"rounds" : [Rounds class]};
}
- (NSString *)getDateInfo
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
- (NSString *)getMatchTypeInfo
{
    if ([self.matchType isEqualToString:@"ELEVEN"]) {
        return @"11人制";
    }
    else if ([self.matchType isEqualToString:@"NINE"])
    {
        return @"9人制";
    }
    else if ([self.matchType isEqualToString:@"EIGHT"])
    {
        return @"8人制";
    }
    else if ([self.matchType isEqualToString:@"SEVEN"])
    {
        return @"7人制";
    }
    else if ([self.matchType isEqualToString:@"SIX"])
    {
        return @"6人制";
    }
    else if ([self.matchType isEqualToString:@"FIVE"])
    {
        return @"5人制";
    }
    return nil;
}
@end

@implementation Rounds

@end


