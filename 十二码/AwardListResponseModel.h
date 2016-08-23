//
//  AwardListResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class AwardListModel,Logo,Tournament,University,Shortcut,Logo,Logo,Area,Universities,Shortcut,Logo;
@interface AwardListResponseModel : NSObject

@property (nonatomic, strong) NSArray<AwardListModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface AwardListModel : NSObject

@property (nonatomic, copy) NSString *owner;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger ownerid;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Logo *logo;

@end





