//
//  InvitationResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class InvitationModel,Stadium,University;
@interface InvitationResponseModel : NSObject

@property (nonatomic, strong) NSArray<InvitationModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface InvitationModel : NSObject

@property (nonatomic, copy) NSString *university;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *contact;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *linkman;

@property (nonatomic, strong) Stadium *stadium;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) long long playDate;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL complete;

- (NSString*)getDate;
@end



