//
//  SEMTeamHomeModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamHomeModel.h"

@implementation SEMTeamHomeModel
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
    [manager fetchTeamInfo:string success:^(id data) {
        self.model = data;
        self.finishenLoading = YES;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchTeamPlayers:string success:^(id data) {
        self.players = data;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"点击了收藏按钮");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
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
