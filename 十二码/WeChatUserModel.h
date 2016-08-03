//
//  WeChatUserModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@interface WeChatUserModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *openid;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSArray<NSString *> *privilege;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, copy) NSString *unionid;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *province;

@end

@interface WeChantaccess_tokenModel : NSObject

@property (nonatomic, copy) NSString *refresh_token;

@property (nonatomic, copy) NSString *scope;

@property (nonatomic, copy) NSString *unionid;

@property (nonatomic, assign) NSInteger expires_in;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *openid;

@end