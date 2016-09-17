//
//  NewsDetailResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReCommendNews.h"
@class NewsDetailModel,Creator,Comments,Comment,Creator,Tag;
@class Remind,Creator,Targetcomment,Reply,BackNews,Medias1;
@interface NewsDetailResponseModel : NSObject

@property (nonatomic, strong) NewsDetailModel *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface NewsDetailModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, strong) NSArray<Tag *> *tags;

@property (nonatomic, strong) NSArray<Medias1*> *medias;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *loves;

@property (nonatomic, strong) NSArray *viewers;
- (NSString*)getInfo;
- (NSString*)getDateInfo;
@end
@interface Medias1 : NSObject

@property (nonatomic,strong) NSString* url;

@property (nonatomic,strong) NSString* type;

@property (nonatomic,assign) NSInteger id;

@end

@interface Comments : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, strong) Comment *comment;

@property (nonatomic, assign) NSInteger news;
- (NSString*)getDate;

@end

@interface Comment : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *replyUser;

@property (nonatomic, strong) NSArray<Reply*> *replies;

@end
@interface Reply : NSObject

@property (nonatomic, strong) Remind *remind;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) Targetcomment *targetComment;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) BOOL read;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic,strong) BackNews* news;

@property (nonatomic,strong) BackNews* hotTopic;
-(NSString*)getdate;
@end


@interface Remind : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *avatar;

@end



@interface Targetcomment : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *replyUser;

@end

@interface NewsDetailModel1 : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger viewed;

@property (nonatomic, strong) NSArray<Tag *> *tags;

@property (nonatomic, strong) NSArray *medias;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) Creator *creator;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *loves;

@property (nonatomic, strong) NSArray *viewers;
- (NSString*)getInfo;
@end
@interface Tag : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,assign) NSInteger rid;
@end
@interface BackNews : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) long long dateCreated;
@end