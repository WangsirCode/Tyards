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
        self.itemName = @[@[@"清除缓存"],@[@"检查更新",@"关于"],@[@"切换账号"]];
        self.version = @"v1.0";
        self.fileSize = [NSString stringWithFormat:@"%lluKB",[DataArchive fileSize:@"cache"]];
    }
    return self;
}
- (void)clearCache
{
    NSLog(@"清除缓存");
    [DataArchive removefile:@"cache"];
    self.fileSize = [NSString stringWithFormat:@"%lluKB",[DataArchive fileSize:@"cache"]];
}
@end
