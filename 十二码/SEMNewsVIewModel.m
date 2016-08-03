//
//  SEMNewsVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMNewsVIewModel.h"
NSString* const NewsCache = @"NewsCache";
NSString* const TopicsCache = @"TopicsCache";
@implementation SEMNewsVIewModel
#pragma mark- initialization
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.title = @"资讯";
        NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
        self.code = [database objectForKey:@"name"];
        self.fisrtGotoTopic = YES;
        self.fisrtGotoAttension = YES;
        [self fecthData];
    }
    return self;
}
- (void)fecthData
{
    NSArray *news = (NSArray*) [DataArchive unarchiveDataWithFileName:NewsCache];
    if (news.count > 0) {
        self.newsDataSource = news;
    }
    else
    {
        self.newsDataSource = [[NSArray alloc] init];
    }
    NSArray* topics= (NSArray*)[DataArchive unarchiveDataWithFileName:TopicsCache];
    if (topics.count > 0) {
        self.topicDataSource = news;
    }
    else
    {
        self.topicDataSource = [[NSArray alloc] init];
    }
}
- (RACCommand*)loadNewNewsCommand
{
    if (!_loadNewNewsCommand) {
        _loadNewNewsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchNews:self.code offset:0 success:^(id data) {
                    self.newsDataSource = data;
                    [DataArchive archiveData:self.newsDataSource withFileName:NewsCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
            }];
    }
    return _loadNewNewsCommand;
}
- (RACCommand*)loadMoreNewsCommand
{
    if (!_loadMoreNewsCommad) {
        _loadMoreNewsCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchNews:self.code offset:0 success:^(id data) {
                    self.topicDataSource = data;
                    [DataArchive archiveData:self.newsDataSource withFileName:TopicsCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _loadMoreNewsCommad;
}
- (RACCommand*)loadNewTopicsCommand
{
    if (!_loadNewTopicsCommand) {
        _loadNewTopicsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchTopics:self.code offset:0 success:^(id data) {
                    self.topicDataSource = data;
                    [DataArchive archiveData:self.newsDataSource withFileName:TopicsCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
        self.fisrtGotoTopic = NO;
    }
    return _loadNewTopicsCommand;
}

- (RACCommand*)loadMoreTopicsCommand
{
    if (!_loadMoreTopicsCommand) {
        _loadMoreTopicsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchTopics:self.code offset:0 success:^(id data) {
                    self.newsDataSource = data;
                    [DataArchive archiveData:self.newsDataSource withFileName:NewsCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _loadMoreTopicsCommand;
}
@end
