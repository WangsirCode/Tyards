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
        self.menuArray = @[@"全部类型",@"5人场",@"6人场",@"7人场",@"8人场",@"9人场",@"11人场"];
        [self fetchData];
    }
    return self;
}
- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchInvitations:[self getToken] success: ^(id data) {
        self.model = data;
        self.anothorModel = data;
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
        
    }];
}
- (void)didSelectItem:(NSInteger)num
{
    NSDictionary* dic = @{@1:@"FIVE",@2:@"SIX",@3:@"SEVEN",@4:@"EIGHT",@5:@"NINE",@6:@"ELEVEN"};
    NSPredicate* pre = [NSPredicate predicateWithFormat:@"type CONTAINS %@",dic[@(num)]];
    if (num == 0) {
        self.model = self.anothorModel;
    }
    else
    {
        self.model = [self.anothorModel filteredArrayUsingPredicate:pre];
    }
}
@end
