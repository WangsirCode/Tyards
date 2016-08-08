//
//  SEMMeViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "UserModel.h"
#import "MeUserInfoResponseModel.h"
@interface SEMMeViewModel : SEMViewModel
@property (nonatomic, strong) UserInfoModel *model;
-(void)fetchUserInfo:(NSString*)token;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong)NSArray* items;
@property (nonatomic,strong)NSArray* images;
@property (nonatomic,strong)UserModel* info;
@property (nonatomic,assign)BOOL isLogined;
@end
