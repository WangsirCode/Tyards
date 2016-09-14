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
    [manager fetchPlayerInfo:playerId success:^(id data) {
        self.model = data;
        self.messageModel = self.model.newses;
        self.status += 1;
    } failure:^(NSError *aError) {
    }];
    [manager fetchPlayerData:playerId token:[self getToken] success:^(id data) {
        self.palyerData = data;
        self.status += 1;
        self.fan = self.palyerData.fan;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                if (self.fan) {
                    [manager postdisLikePlayer:[@(self.model.player.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = NO;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                else
                {
                    [manager postLikePlayer:[@(self.model.player.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = YES;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
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
