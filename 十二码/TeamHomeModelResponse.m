//
//  TeamHomeModelResponse.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamHomeModelResponse.h"

@implementation TeamHomeModelResponse

@end
@implementation TeamHomeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"articles" : [Articles class], @"newses" : [Newses class]};
}

@end



@implementation Cover

@end


@implementation Articles
- (NSString*)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy.MM.dd";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}

- (NSString*)getInfo
{
    NSMutableString* info = [NSMutableString stringWithString:self.author];
    [info appendString:@" / "];
    [info appendString:[self getDate]];
    return info;
}
@end





@implementation Newses

+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [Comments class]};
}

@end


//
//@implementation Comments1
//
//@end



