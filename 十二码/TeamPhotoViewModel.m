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
        [manager fetchTeamAlbums:string success:^(id data) {
            self.model = data;
            self.shouldReloadData = YES;
        } failure:^(NSError *aError) {
            
        }];
}
@end
