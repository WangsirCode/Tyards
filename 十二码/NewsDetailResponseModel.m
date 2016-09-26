//
//  NewsDetailResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsDetailResponseModel.h"

@implementation NewsDetailResponseModel

@end
@implementation NewsDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [Comments class],@"tags" : [Tag class],@"medias": [Medias1 class]};
}
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
- (NSString *)getDateInfo
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM月dd日  hh : mm ";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end


@implementation Comments
- (NSString*)getDate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM月dd日 HH : mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end


@implementation Comment
+ (NSDictionary *)objectClassInArray{
    return @{@"replies" : [Reply class]};
}
@end

@implementation Reply

-(NSString *)getdate
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:self.dateCreated/1000];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM月dd日 HH : mm";
    NSString* ta = [formater stringFromDate:date];
    return ta;
}
@end
@implementation Medias1


@end

@implementation Remind

@end


@implementation Targetcomment

@end

@implementation NewsDetailModel1
+ (NSDictionary *)objectClassInArray{
    return @{@"comments" : [Comments class]};
}
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
    NSMutableString* info = [NSMutableString stringWithString:self.creator.nickname];
    [info appendString:@" / "];
    [info appendString:[self getDate]];
    return info;
}

@end
@implementation Tag



@end

@implementation BackNews


@end
