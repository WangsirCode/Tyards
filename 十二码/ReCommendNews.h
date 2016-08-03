//
//  ReCommendNews.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class News,Creator,Thumbnail;
@interface ReCommendNews : NSObject<NSCoding>

@property (nonatomic, strong) NSArray<News      *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface News : NSObject<NSCoding>

@property (nonatomic, strong) Thumbnail *thumbnail;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *title;

@property (nonatomic, assign) long    long      dateCreated;

@property (nonatomic, copy  ) NSString  *type;

@property (nonatomic, strong) Creator   *creator;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) NSInteger commentCount;
- (NSString*)getDate;
- (NSString*)getInfo;
@end

@interface Creator : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *nickname;

@property (nonatomic, copy  ) NSString  *avatar;

@end

@interface Thumbnail : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *url;

@property (nonatomic, copy  ) NSString  *type;

@end

