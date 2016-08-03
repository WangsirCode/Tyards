//
//  SEMMeViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMMeViewModel.h"

@implementation SEMMeViewModel
#pragma mark- initialization
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.title = @"我的信息";
        self.items = @[@"个人资料",@"我的关注",@"评论/回复",@"约战",@"意见反馈",@"好友推荐",@"设置"];
        self.images = @[@"个人资料icon",@"我的关注icon",@"消息通知icon",@"约战icon",@"意见反馈icon",@"好友推荐icon",@"设置icon"];
    }
    return self;
}
@end
