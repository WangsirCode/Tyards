//
//  TeamCommentsResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamCommentsResponseModel.h"
#import "MDABizManager.h"
@implementation TeamCommentsResponseModel
+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [NewsDetailModel class]};
}
@end
