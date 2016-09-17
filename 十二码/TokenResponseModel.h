//
//  TokenResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/16.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeUserInfoResponseModel.h"
@interface TokenModel : NSObject
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) UserInfoModel* user;
@end
@interface TokenResponseModel : NSObject
@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) TokenModel* resp;
@end
