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
        self.model = [[InvitationModel alloc] init];
        self.model.stadium = [[Stadium alloc] init];
        NSDate *date = [[NSDate alloc] init];
        self.model.playDate = [date timeIntervalSince1970] * 1000;
        self.model.title = @"";
        self.model.type = @"";
        self.model.contact = @"";
        self.model.linkman = @"";
        self.model.desc = @"";
        self.shouldReloadData = YES;
        self.valid = YES;
    }
    return self;
}
- (RACCommand *)postCommand
{
    if (!_postCommand) {
        _postCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                 SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                if ([self.model.title isEqualToString:@""]) {
                    self.valid = NO;
                }
                else
                {
                    if([self.model.desc isEqualToString:@"备注信息让各大球队提高对你的兴趣吧"])
                    {
                        self.model.desc = @"";
                    }
                    self.valid = YES;
                    [manager postInvitation:self.model.title date:self.model.playDate stadium:self.model.stadium.id type:self.model.type contact:self.model.contact linkman:self.model.linkman description:self.model.desc token:[self getToken] success:^(id data) {
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }

                return nil;
            }];
        }];
    }
    return _postCommand;
}
@end
