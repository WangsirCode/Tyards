//
//  MyConcernViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyConcernViewModel.h"

@implementation MyConcernViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        NSString* stirng = [(NSNumber*)dictionary[@"id"] stringValue];
        [self fetchData:stirng];
    }
    return self;
}
-(void)fetchData:(NSString*)ide
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchMyConcern:ide success:^(id data) {
        self.model = data;
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
        
    }];
}
@end
