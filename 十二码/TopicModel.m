//
//  TopicModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel


MJCodingImplementation


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [Topic1 class]};
}

@end


@implementation Topic1
MJCodingImplementation
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


@implementation Creator1
MJCodingImplementation

@end


@implementation Thumbnail1
MJCodingImplementation
@end


