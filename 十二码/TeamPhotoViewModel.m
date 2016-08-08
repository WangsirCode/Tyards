//
//  TeamPhotoViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamPhotoViewModel.h"
#import "MDABizManager.h"
@implementation TeamPhotoViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        [self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
    }
    return self;
}
- (void)fetchData:(NSString*)string
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchTeamComments:@"60" success:^(id data) {
        
    } failure:^(NSError *aError) {
        
    }];

    [manager fetchNewsDetail:783 success:^(id data) {
        [manager fetchTeamComments:@"60" success:^(id data) {
            
        } failure:^(NSError *aError) {
            
        }];
    } failure:^(NSError *aError) {
        
    }];
}
@end
