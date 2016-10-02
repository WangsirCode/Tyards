//
//  TeamHomeModelResponse.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReCommendNews.h"
#import "SearchModel.h"
#import "MDABizManager.h"
@class TeamHomeModel,Info,Cover,Articles,Thumbnail,Newses,Comments1,Coach,Record,Comments;

@interface TeamHomeModelResponse : NSObject

@property (nonatomic, strong) TeamHomeModel *resp;

@property (nonatomic, assign) NSInteger code;

@end

@interface TeamHomeModel : NSObject

@property (nonatomic, strong) NSArray<Articles *> *articles;

@property (nonatomic, strong) Info *info;

@property (nonatomic, strong) NSArray<Newses *> *newses;

@end



@interface Cover : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *type;

@end

@interface Articles : NSObject

@property (nonatomic, strong) Thumbnail *thumbnail;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic,strong) NSString* author;
- (NSString*)getInfo;
@end



@interface Newses : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, strong) NSArray *medias;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *loves;

@property (nonatomic, strong) NSArray *viewers;

@end



//@interface Comments1 : NSObject
//
//@property (nonatomic, assign) NSInteger id;
//
//@property (nonatomic, assign) long long dateCreated;
//
//@property (nonatomic, copy) NSString *content;
//
//@property (nonatomic, strong) Creator *creator;
//
//@property (nonatomic, copy) NSString *replyUser;
//
//@end







