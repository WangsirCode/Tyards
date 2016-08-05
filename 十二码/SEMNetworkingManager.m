//
//  SEMNetworkingManager.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "NewsDetailResponseModel.h"
#import "SEMNetworkingManager.h"
#import "GameDetailModel.h"
#import "GameListResponseModel.h"
#import "TeamLisstResponseModel.h"
#import "TeamHomeModelResponse.h"
#import "TeamPlayerResponseModel.h"
NSString* const hotTopics = @"/university/hotTopics";
NSString* const hotTopicsCache = @"hotTopicsCache";
NSString* const ReconmendNewsURL = @"/university/editorViews";
NSString* const SchoolListURL = @"/area/list";
NSString* const SearchResult = @"/university/search";
NSString* const NewsURL = @"/university/articles";
NSString* const TopicsURL = @"/university/topics";
NSString* const NoticeGameURL = @"/university/previewMatchesGroup";
NSString* const HistoryGameURL = @"/university/reviewMatchesGroup";
NSString* const GameListURL = @"/university/tournaments";
NSString* const NewDetailURL = @"/news/detail";
NSString* const WexinURL = @"/user/wxToken";
NSString* const qqURL = @" /user/qqToken";
NSString* const teamList = @"/university/teams";
NSString* const TeamInfo = @"/team/detail/";
NSString* const TeamPlayer = @"/team/players/";
NSString* const TeamComments = @"/team/newses/";
@implementation SEMNetworkingManager
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURL* url = [NSURL URLWithString: @"http://dev.12yards.cn"];
        _sharedInstance = [[self alloc] initWithBaseURL: url];
    });
    return _sharedInstance;
}

- (NSURLSessionTask*)fetchHotTopics:(NSString*)code
                            success:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:code];
    [URL appendString:hotTopics];
    
    return [self GET: URL parameters: nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        hotTopicsModel* model = [hotTopicsModel mj_objectWithKeyValues:responseObject];
        NSMutableArray* news = [NSMutableArray arrayWithArray:model.resp];
        successBlock(news);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}

- (NSURLSessionTask*)fetchReCommendNews:(NSString*)code
                                 offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:code];
    [URL appendString:ReconmendNewsURL];
    NSDictionary *para = @{@"offset":@(offset)};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ReCommendNews* model =[ReCommendNews mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchSchoolList:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    return [self GET:SchoolListURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SearchModel* model = [SearchModel mj_objectWithKeyValues:responseObject];
        NSArray* area = model.resp;
        successBlock(area);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }
            ];
}

- (NSURLSessionTask *)fetchSearchResults:(NSString *)name success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    NSDictionary *para = @{@"q":name};
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    return [self GET:SearchResult parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SearchResultsModel* model = [SearchResultsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}
- (NSURLSessionTask *)fetchNews:(NSString *)name offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSDictionary *para = @{@"offset":@(offset)};
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    [URL appendString:name];
    [URL appendString:NewsURL];
    return  [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsModel *model = [NewsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchTopics:(NSString *)name offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:name];
    [URL appendString:TopicsURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TopicModel* model = [TopicModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchNoticeGame:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:NoticeGameURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel* model = [GameDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

- (NSURLSessionTask *)fetchHistoryGame:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:HistoryGameURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel* model = [GameDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchGameList:(NSString *)schoolCode offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    NSDictionary *para = @{@"offset":@(offset)};
    [URL appendString:schoolCode];
    [URL appendString:GameListURL];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameListResponseModel* model = [GameListResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
-(NSURLSessionTask *)fetchNewsDetail:(NSInteger)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *para = @{@"id":@(ide)};
    return [self GET:NewDetailURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsDetailResponseModel* model = [NewsDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (NSURLSessionTask *)fetchWexinToken:(NSString *)token openid:(NSString *)openid success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSDictionary *para = @{@"access_token":token,@"openid":openid};
    return [self GET:WexinURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject[@"resp"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}
- (NSURLSessionTask *)fetchQQToken:(NSString *)token openid:(NSString *)openid success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSDictionary *para = @{@"access_token":token,@"openid":openid};
    return [self GET:qqURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

//球队列表
-(NSURLSessionTask *)fetchTeamList:(NSString *)schoolcode searchName:(NSString *)name success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [NSMutableString stringWithString:@"/"];
    
    NSDictionary *para = @{@"q":name};
    [URL appendString:schoolcode];
    [URL appendString:teamList];
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamLisstResponseModel* model = [TeamLisstResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//球队主页信息
-(NSURLSessionTask *)fetchTeamInfo:(NSString *)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamInfo];
    [URL appendString:ide];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamHomeModelResponse* model = [TeamHomeModelResponse mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//球队队员信息
- (NSURLSessionTask *)fetchTeamPlayers:(NSString *)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamPlayer];
    [URL appendString:ide];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamPlayerResponseModel* model = [TeamPlayerResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
- (NSURLSessionTask *)fetchTeamComments:(NSString *)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamComments];
    [URL appendString:ide];
    NSDictionary* para = @{@"unflattern":@YES};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray<NewsDetailModel*>* model = [NSArray mj_objectWithKeyValues:responseObject];
        successBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end

