//
//  PlayerDetailViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerDetailViewModel.h"

@implementation PlayerDetailViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        [self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
    }
    return self;
}
- (void)fetchData:(NSString*)playerId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    //暂时用这个id测试
    [manager fetchPlayerInfo:@"583" success:^(id data) {
        self.model = data;
        NSMutableArray* array = [[NSMutableArray alloc] init];
        [self.model.newses enumerateObjectsUsingBlock:^(Newses * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array appendObject:obj.comments];
        }];
        self.comments = [NSArray arrayWithArray:array];
        self.status += 1;
    } failure:^(NSError *aError) {
    }];
    [manager fetchPlayerData:@"583" token:[self getToken] success:^(id data) {
        self.palyerData = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager postdisLikePlayer:[@(self.model.player.id) stringValue] token:[self getToken] success:^(id data) {
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                } failure:^(NSError *aError) {
                    
                }];
                return nil;
                return nil;
            }];
        }];
    }
    return _likeCommand;
}
- (RACCommand *)shareCommand
{
    if (!_shareCommand) {
        _shareCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"点击了分享按钮");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _shareCommand;
}
@end
