//
//  ChangeNickNameViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ChangeNickNameViewModel.h"

@implementation ChangeNickNameViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.name = dictionary[@"name"];
    }
    return self;
}

@end
