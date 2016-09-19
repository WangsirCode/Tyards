//
//  SEMHomeVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "DataArchive.h"
#import "SEMHomeVIewModel.h"
#import "SEMNetworkingManager.h"
NSString* const newscash = @"newsdatacache";
NSString* const imagescash = @"imagecache";
@implementation SEMHomeVIewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString* code = [self getSchoolCode];
        NSString* name = [self getSchoolName];
        if (code) {
            self.code = code;
        }
        else
        {
            self.code = @"hust";
            NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
            [database setObject:self.code forKey:@"name"];
        }
        if (name) {
            self.title = name;
        }
        else
        {
            self.title = @"华中科技大学";
        }
        self.index = 0;


        [self fetchData];
    }
    return self;
}

- (void)fetchData
{
    NSArray *news = (NSArray*) [DataArchive unarchiveDataWithFileName:newscash];
    NSArray* topics = (NSArray*) [DataArchive unarchiveDataWithFileName:imagescash];
    if (news.count > 0) {
        self.datasource = news;
    }
    else
    {
        self.datasource = [[NSArray alloc] init];
    }
    if (topics.count > 0) {
        self.topics = topics;
    }
    else
    {
        self.topics = [[NSArray alloc] init];
    }
}

- (RACCommand*)loadNewCommand
{
    if (!_loadNewCommand)
    {
        _loadNewCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在更新数据");
                self.index = 0;
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchReCommendNews:self.code offset:0 success:^(id data) {
                    self.datasource = data;
                    [subscriber sendNext:@1];
                    self.index += 1;
                    if (self.index == 2) {
                        [subscriber sendCompleted];
                    }
                    
                    [DataArchive archiveData:self.datasource withFileName:newscash];
                } failure:^(NSError *aError) {
                    NSLog(@"%@",aError);
                }];
                [manager fetchHotTopics:self.code
                                success:^(id data) {
                    self.topics = data;
                    [subscriber sendNext:@2];
                    self.index += 1;
                    if (self.index == 2) {
                        [subscriber sendCompleted];
                    }
                    [DataArchive archiveData:self.topics withFileName:imagescash];
                } failure:^(NSError *aError) {
                    
                }];

                return nil;
            }];
        }];
    }
    return _loadNewCommand;
}

- (RACCommand*)loadMoreCommand
{
    if (!_loadMoreCommand) {
        _loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在获取更过数据");
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchReCommendNews:self.code
                                     offset:self.datasource.count success:^(id data) {
                    NSMutableArray* array = [NSMutableArray arrayWithArray:self.datasource];
                    [array arrayByAddingObjectsFromArray:(NSArray*)data];
                    self.datasource = nil;
                    self.datasource = array;
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    NSLog(@"%lu",(unsigned long)self.datasource.count);
                    [DataArchive archiveData:self.datasource withFileName:newscash];
                } failure:^(NSError *aError) {
                    NSLog(@"%@",aError);
                }];
                
                return nil;
            }];
        }];
    }
    return _loadMoreCommand;
}
- (RACCommand*)searchCommand
{
    if (!_searchCommand){
        _searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"切换到搜索界面");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _searchCommand;
}
@end
