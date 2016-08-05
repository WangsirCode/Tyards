//
//  SEMTeamViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamViewModel.h"
#import "MDABizManager.h"
@implementation SEMTeamViewModel
#pragma mark- initialization
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.title = @"球队";
        [self fetchData];
    }
    return self;
}
- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchTeamList:[self getSchoolCode] searchName:@"" success:^(id data) {
        self.model = data;
        self.needReloadTableview = YES;
    } failure:^(NSError *aError) {
        
    }];
}

#pragma mark-Getter

- (RACCommand*)searchCommand
{
    if (!_searchCommand) {
        _searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString* input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在搜索");
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchTeamList:[self getSchoolCode] searchName:input success:^(id data) {
                    self.teams = data;
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _searchCommand;
}
@end
