//
//  MakeInvitationViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MakeInvitationViewModel.h"

@implementation MakeInvitationViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.titleArray = @[@"标题",@"日期",@"时间",@"场地",@"类型",@"联系人",@"联系方式"];
        [self fetchData];
    }
    return self;
}
- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchInvitations:^(id data) {
        self.shouldReloadData = YES;
    } failure:^(NSError *aError) {
    }];
}
- (RACCommand *)postCommand
{
    if (!_postCommand) {
        _postCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _postCommand;
}
@end
