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
        self.topicDataSource = topics;
    }
    else
    {
        self.topicDataSource = [[NSArray alloc] init];
    }
    NSArray* fans = (NSArray*)[DataArchive unarchiveDataWithFileName:@"attension"];
    if (fans.count > 0) {
        self.attensionDatasource = fans;
    }
    else
    {
        self.attensionDatasource = [NSArray new];
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
- (RACCommand *)loadNewFansCommand
{
    if (!_loadNewFansCommand) {
        _loadNewFansCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                NSString *token = [self getToken];
                if (token) {
                    [manager fetchMyFans:token offset:0 success:^(id data) {
                        self.attensionDatasource = data;
                        [DataArchive archiveData:self.attensionDatasource withFileName:@"attension"];
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                        
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                return nil;
            }];
        }];
    }
    return _loadNewFansCommand;
}
- (RACCommand *)loadMoreFansCommand
{
    if (!_loadMoreFansCommand) {
        _loadMoreFansCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                NSString *token = [self getToken];
                NSInteger count = self.attensionDatasource.count;
                if (token && count > 0) {
                    [manager fetchMyFans:token offset:count success:^(id data) {
                        NSMutableArray<News*> *array = [NSMutableArray arrayWithArray:self.attensionDatasource];
                        [array appendObjects:data];
                        self.attensionDatasource = array;
                        [DataArchive archiveData:self.attensionDatasource withFileName:@"attension"];
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                        
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                return nil;
            }];
        }];
    }
    return _loadMoreFansCommand;
}
- (RACCommand*)loadMoreNewsCommand
{
    if (!_loadMoreNewsCommad) {
        _loadMoreNewsCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchNews:self.code offset:self.newsDataSource.count success:^(id data) {
                    NSMutableArray<News*> *array = [NSMutableArray arrayWithArray:self.newsDataSource];
                    [array appendObjects:data];
                    self.newsDataSource = array;
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
                    [DataArchive archiveData:self.topicDataSource withFileName:TopicsCache];
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
                [manager fetchTopics:self.code offset:self.topicDataSource.count success:^(id data) {
                    NSMutableArray *array = [NSMutableArray arrayWithArray:self.topicDataSource];
                    [array appendObjects:data];
                    self.topicDataSource = array;
                    [DataArchive archiveData:self.topicDataSource withFileName:TopicsCache];
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
