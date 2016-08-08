//
//  SetUpViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SetUpViewModel.h"
#import "MDABizManager.h"
@implementation SetUpViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.isLogined = [dictionary[@"login"] boolValue];
        self.itemName2 = @[@[@"清除缓存",@"检查更新",@"关于"],@[@"切换账号"]];
        self.itemName1 = @[@[@"清除缓存",@"意见反馈",@"推荐好友"],@[@"检查更新",@"关于"],@[@"切换账号"]];
        self.version = @"v1.0";
        self.fileSize = [NSString stringWithFormat:@"%lluM",[DataArchive fileSize:@"cache"]];
    }
    return self;
}
- (void)clearCache
{
    NSLog(@"清除缓存");
    [DataArchive removefile:@"cache"];
}
@end
