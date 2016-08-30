//
//  MyInvitationViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyInvitationViewModel.h"

@implementation MyInvitationViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        [self fetchData];
    }
    return self;
}
- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchMyClosedInvitations:[self getToken] success:^(id data) {
        self.myClosedInvitations = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchMyInvitations:[self getToken] success:^(id data) {
        self.myInvitaions = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
}
@end
