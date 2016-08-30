//
//  MyInvitationResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyInvitationResponseModel.h"

@implementation MyInvitationResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [InvitationModel class]};
}
@end
