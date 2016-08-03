//
//  LoginCommand.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "LoginCommand.h"
#import "UserModel.h"
@implementation LoginCommand
static LoginCommand* _instance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}
- (RACCommand *)weixinLoginedCommand
{
    if (!_weixinLoginedCommand) {
        _weixinLoginedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UserModel* input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _weixinLoginedCommand;
}
@end
