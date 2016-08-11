//
//  AlbumDetailViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "AlbumDetailViewModel.h"

@implementation AlbumDetailViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        [self fetchData:[(NSNumber*)dictionary[@"id"] integerValue]];
        self.title = dictionary[@"title"];
    }
    return self;
}
- (void)fetchData:(NSInteger)albumId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchAlbumDetail:albumId success:^(id data) {
        self.model = data;
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
    }];
}
@end
