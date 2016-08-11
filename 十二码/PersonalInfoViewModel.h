//
//  PersonalInfoViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "UserModel.h"
#import "MeUserInfoResponseModel.h"
@interface PersonalInfoViewModel : SEMViewModel
@property (nonatomic, strong) UserInfoModel *model;
@property (nonatomic,strong)NSArray* cellText;
@property (nonatomic,strong)NSArray* cellDetail;
@property (nonatomic,strong)NSArray* genderArrat;
@property (nonatomic,strong)NSDictionary* gender;
@property (nonatomic,strong) RACCommand* postCommand;
- (void)getDetail;
@end
