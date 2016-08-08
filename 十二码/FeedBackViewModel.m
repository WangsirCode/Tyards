//
//  FeedBackViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "FeedBackViewModel.h"

@implementation FeedBackViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {

    }
    return self;
}
-(RACCommand *)submitCommand
{
    if (!_submitCommand) {
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager postFeebback:self.feedBack success:^(id data) {
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                } failure:^(NSError *aError) {
                }];
                return nil;
            }];
        }];
    }
    return _submitCommand;
}
@end
