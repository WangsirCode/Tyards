//
//  MeColleageSearchViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MeColleageSearchViewModel.h"

@implementation MeColleageSearchViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString* string = [(NSNumber*)dictionary[@"code"] stringValue];
        [self fetchData:string];
    }
    return self;
}
- (void)fetchData:(NSString*)stirng
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchColleges:stirng success:^(id data) {
        self.dataSource = data;
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
                NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",input];
                self.universities = [self.dataSource filteredArrayUsingPredicate:predicate];
                [subscriber sendNext:@1];
                [subscriber sendCompleted];

                return nil;
            }];
        }];
    }
    return _searchCommand;
}
@end
