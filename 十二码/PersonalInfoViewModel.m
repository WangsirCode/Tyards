//
//  PersonalInfoViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PersonalInfoViewModel.h"
@implementation PersonalInfoViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
         self.model = dictionary[@"model"];
        self.cellText = @[@"所在院校",@"所属学院",@"性别",@"生日"];
        self.genderArrat = @[@"男",@"女"];
        self.gender = @{@"男":@"MALE",@"女":@"FEMALE"};
        [self getDetail];
        NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
        NSString* token = (NSString*)[data objectForKey:@"token"];
        [self fetchUserInfo:token];
    }
    return self;
}
- (void)fetchUserInfo:(NSString*)token
{
    if ([DataArchive unarchiveUserDataWithFileName:@"UserInfo"]) {
        self.model = (UserInfoModel*)[DataArchive unarchiveUserDataWithFileName:@"UserInfo"];
    }
    else
    {
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        //测试时先用这个token
        [manager fetchUserInfo:@"d16c7f4be4a02398c4af50bdc8c1db06" success:^(id data) {
            self.model = data;
            self.shouldReloadData = YES;
            [DataArchive archiveUserData:self.model withFileName:@"UserInfo"];
        } failure:^(NSError *aError)
        {
            
        }];
    }
    
}
- (void)getDetail
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    if (self.model.university.name) {
        [array appendObject:self.model.university.name];
    }
    else
    {
        [array appendObject:@"未选择学校"];
    }
    if (self.model.college) {
        [array addObject:self.model.college.name];
    }
    else
    {
        [array appendObject:@"未选择学院"];
    }
    if (self.model.gender) {
        if ([self.model.gender isEqualToString:@"MALE"]) {
            [array appendObject:@"男"];
        }
        else
        {
            [array addObject:@"女"];
        }
        
    }
    else
    {
        [array addObject:@"未选择性别"];
    }
    if (self.model.birthDay > 1000) {
        [array addObject: [self.model getMyBirthday]];
    }
    else
    {
        [array appendObject:@"未填写生日"];
    }
    self.cellDetail = [NSArray arrayWithArray:array];
    
}
- (RACCommand *)postCommand
{
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
//    NSString* token = [data objectForKey:@"token"];
    NSString* token = @"d16c7f4be4a02398c4af50bdc8c1db06";
    if (!_postCommand) {
        _postCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager postUserInfo:self.model.university.id collegeId:self.model.college.id gender:self.model.gender birthday:self.model.birthDay token:token success:^(id data) {
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                } failure:^(NSError *aError) {
                    
                }];
                return nil;
            }];
        }];
    }
    return _postCommand;
}
@end
