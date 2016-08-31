//
//  PlaceViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlaceViewModel.h"

@implementation PlaceViewModel
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
    [manager fetchPlaceList:[self getSchoolCode] success:^(id data) {
        self.model = data;
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
        
    }];
}
@end
