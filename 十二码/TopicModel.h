

//
//  TopicModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/25.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"



@class Topic1,Creator1,Thumbnail1;
@interface TopicModel : NSObject<NSCoding>
@property (nonatomic, strong) NSArray<Topic1 *> *resp;

@property (nonatomic, assign) NSInteger code;

@end


@interface Topic1 : NSObject<NSCoding>

@property (nonatomic, strong) Thumbnail1 *thumbnail;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) Creator1 *creator;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic,strong) NSString* author;

- (NSString*)getInfo;

@end

@interface Creator1 : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *avatar;

@end

@interface Thumbnail1 : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *type;

@end

