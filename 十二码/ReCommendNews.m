//
//  ReCommendNews.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ReCommendNews.h"

@implementation ReCommendNews

MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [News class]};
}

@end


@implementation News
- (NSString*)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM.dd";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}

- (NSString*)getInfo
{
    NSMutableString* info = [NSMutableString stringWithString:self.author];
    if (info.length > 6) {
        NSString* string = [info substringWithRange:NSMakeRange(0, 6)];
        info = [NSMutableString stringWithFormat:@"%@...",string];
        
    }
    [info appendString:@" / "];
    [info appendString:[self getDate]];
    return info;
}
MJCodingImplementation
@end


@implementation Creator
MJCodingImplementation
@end


@implementation Thumbnail
MJCodingImplementation
@end


