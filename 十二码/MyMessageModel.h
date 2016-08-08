//
//  MyMessageModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class Resp,Reply,Remind,Creator,Targetcomment,Creator,Comment,Creator,Replies,Remind,Creator,Targetcomment,Creator;
@interface MyMessageModel : NSObject

@property (nonatomic, strong) NSArray<Resp *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface Resp : NSObject

@property (nonatomic, strong) Reply *reply;

@property (nonatomic, strong) Comment *comment;

@end





@interface Replies : NSObject

@property (nonatomic, strong) Remind *remind;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) Targetcomment *targetComment;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) BOOL read;

@property (nonatomic, strong) Creator *creator;

@end







