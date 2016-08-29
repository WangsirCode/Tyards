//
//  InvitationVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationVIewModel.h"

@implementation InvitationVIewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        [self fetchData];
    }
    return self;
}
- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchInvitations:^(id data) {
        self.model = data;
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
        
    }];
}
@end
