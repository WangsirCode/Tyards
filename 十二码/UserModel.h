//
//  UserModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@interface UserModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimgurl;
@end
