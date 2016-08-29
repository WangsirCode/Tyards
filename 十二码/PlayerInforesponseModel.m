//
//  PlayerInforesponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerInforesponseModel.h"

@implementation PlayerInforesponseModel

@end

@implementation CoachInfoResponseModel

@end

@implementation PlayerModel
+ (NSDictionary *)objectClassInArray{
    return @{@"articles" : [Articles class], @"newses" : [Newses class]};
}

@end

@implementation CoachModel
+ (NSDictionary *)objectClassInArray{
    return @{@"articles" : [Articles class], @"newses" : [Newses class]};
}

@end
@implementation PlayerDetail
- (NSString *)weightInfo
{
    return [NSString stringWithFormat:@"%ldkg",(long)self.weight];
}
- (NSString *)heightInfo
{
    return [NSString stringWithFormat:@"%ldm",self.height];
}
- (NSString *)PosionInfo
{
    if ([self.position isEqualToString:@"UNKNOWN"]) {
        return @"未知";
    }
    else if ([self.position isEqualToString:@"BACKFIELD"])
    {
        return @"后卫";
    }
    else if ([self.position isEqualToString:@"MIDFIELD"])
    {
        return @"中场";
    }
    else if ([self.position isEqualToString:@"FORWARD"])
    {
        return @"前锋";
    }
    else
    {
        return @"守门员";
    }
}
@end


