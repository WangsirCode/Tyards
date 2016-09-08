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
        self.medias = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)fetchData:(NSInteger)albumId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchAlbumDetail:albumId offset:self.medias.count success:^(id data) {
        [self.medias appendObjects:((AlbumModel*)data).medias];
        self.number = ((AlbumModel*)data).total;
        if (self.medias.count < self.number) {
            [self fetchData:albumId];
        }
        else
        {
            self.model = [AlbumModel new];
            self.model.medias = self.medias;
            self.shouldReloadData = YES;
        }
    } failure:^(NSError *aError) {
    }];
}
@end
