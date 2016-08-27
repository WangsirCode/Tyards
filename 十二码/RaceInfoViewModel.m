//
//  RaceInfoViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "RaceInfoViewModel.h"

@implementation RaceInfoViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        //[self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
        [self fetchData:@"291"];
    }
    return self;
}
- (void)fetchData:(NSString*)matchId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameNews:matchId success:^(id data) {
        self.newsModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchGameDetail:matchId success:^(id data) {
        self.gameModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchGameMessage:matchId success:^(id data) {
        self.messageModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchRaceData:matchId success:^(id data) {
        self.dataModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
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
