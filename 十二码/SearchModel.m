//
//  SearchModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

MJCodingImplementation

+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [Area class]};
}
@end


@implementation Universities
MJCodingImplementation
@end


@implementation Shortcut
MJCodingImplementation
@end


@implementation Logo
MJCodingImplementation
@end


@implementation Area
MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"universities" : [Universities class]};
}

@end

//@implementation SearchResultsModel
//
//@end


