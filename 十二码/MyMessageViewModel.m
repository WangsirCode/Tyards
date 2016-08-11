//
//  MyMessageViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyMessageViewModel.h"

@implementation MyMessageViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        //NSString* token = [self getToken];
        
        //暂时用这个测试
        [self fetchData:@"d16c7f4be4a02398c4af50bdc8c1db06"];
    }
    return self;
}
-(void)fetchData:(NSString*)ide
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchMyReplies:ide success:^(id data) {
        self.model = data;
        self.shouldReloadDate = YES;
    } failure:^(NSError *aError) {
        
    }];
}
@end
