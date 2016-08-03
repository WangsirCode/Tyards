//
//  SEMSearchViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMSearchViewModel.h"
#import "SEMNetworkingManager.h"
@implementation SEMSearchViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        [self fetchData];
    }
    return self;
}

- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchSchoolList:^(id data) {
        self.datasource = data;
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
                [manager fetchSearchResults:input success:^(id data) {
                    self.universities = data;
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
