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
#import "MeUserInfoResponseModel.h"
#import "TeamCommentsResponseModel.h"
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
NSString* const qqURL = @"/user/qqToken";
NSString* const teamList = @"/university/teams";
NSString* const TeamInfo = @"/team/detail/";
NSString* const TeamPlayer = @"/team/players/";
NSString* const TeamComments = @"/team/newses/";
NSString* const TeamGames = @"/team/games/";
NSString* const UserInfo = @"/user/info";
NSString* const Colleges = @"/university/collegesApi/";
NSString* const UpdateInfo = @"/user/updateInfo";
NSString* const UserReply = @"/user/replies";
NSString* const MyConcern = @"/user/fans/";
NSString* const FeedBack = @"/feedback/post";
NSString* const TeamAlbums = @"/team/albums/";
NSString* const AlbumDetail = @"/album/medias";
NSString* const TeamDetailInfo = @"/team/info/";
NSString* const PlayerInfo = @"/player/info/";
NSString* const LikePlyer = @"/user/fansPlayer/";
NSString* const disLikePlayer = @"/user/unFansPlayer/";
NSString* const LikeCoach = @"/user/fansCoach/";
NSString* const disLikeCoach = @"/user/removeFans/";
NSString* const likeTeam = @"/user/fansTeam/";
NSString* const dislikeTeam = @"/user/removeFansTeam/";
NSString* const likeGame = @"/user/fansTournament/";
NSString* const disLikegame = @"/user/removeFansTournament/";
NSString* const GameInfo = @"/tournament/info/";
NSString* const GameSchedule = @"/tournament/games/";
NSString* const GameTeams = @"/tournament/teams/";
NSString* const GameNews = @"/match/articles/";
NSString* const GameDetails = @"/match/detail/";
NSString* const GameMessage = @"/match/newses/";
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
        successBlock(responseObject[@"resp"]);
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
- (NSURLSessionTask *)fetchTeamPlayers:(NSString *)ide from:(long long)from to:(long long)to success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamPlayer];
    [URL appendString:ide];
    NSDictionary* para;
    if (from == 0) {
        para = nil;
    }
    else
    {
        para = @{@"from":@(from),@"to":@(to)};
    }
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamPlayerResponseModel* model = [TeamPlayerResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取评论
- (NSURLSessionTask *)fetchTeamComments:(NSString *)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamComments];
    [URL appendString:ide];
    NSDictionary* para = @{@"unflattern":@YES};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamCommentsResponseModel* result = [TeamCommentsResponseModel mj_objectWithKeyValues:responseObject];
        NSArray<NewsDetailModel*>* model = result.resp;
        NSMutableArray<Comments*>* array =[[NSMutableArray alloc] init];
        [model enumerateObjectsUsingBlock:^(NewsDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array appendObjects:obj.comments];
        }];
        
        NSArray* result1 = [[NSArray alloc] initWithArray:array];
        successBlock(result1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
- (NSURLSessionTask *)fetchTeamGames:(NSString *)ide from:(long long)from to:(long long)to success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamGames];
    [URL appendString:ide];
    NSDictionary* para;
    if (from == 0) {
        para = @{@"group":@YES};
    }
    else
    {
        para = @{@"group":@YES,@"from":@(from),@"to":@(to)};
    }
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel* model = [GameDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}
-(NSURLSessionTask *)fetchUserInfo:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:UserInfo];

    NSDictionary* para = @{@"token":token};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MeUserInfoResponseModel* model = [MeUserInfoResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
- (NSURLSessionTask *)fetchColleges:(NSString *)ide success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:Colleges];
    [URL appendString:ide];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray<College*>* model = [College mj_objectArrayWithKeyValuesArray:responseObject[@"resp"]];
        successBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}


//提交信息
-(NSURLSessionTask *)postUserInfo:(NSInteger)schoolId collegeId:(NSInteger)collegeId gender:(NSString *)gender birthday:(long long)birthday token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:UpdateInfo];
    
    NSDictionary* para = @{@"university":@(schoolId),@"college":@(collegeId),@"gender":gender,@"birthday":@(birthday),@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取评论信息
-(NSURLSessionTask *)fetchMyReplies:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:UserReply];
    
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyMessageModel* model = [MyMessageModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取我的关注

- (NSURLSessionTask *)fetchMyConcern:(NSString*)ids success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:MyConcern];
    [URL appendString:ids];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyConcernModel* model = [MyConcernModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//提交反馈
-(NSURLSessionTask *)postFeebback:(NSString *)feedback success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:FeedBack];
    NSDictionary *para = @{@"content":feedback};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取球队相册

-(NSURLSessionTask *)fetchTeamAlbums:(NSString *)teamId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamAlbums];
    //测试以这个未测试
    [URL appendString:teamId];
    
    // [URL appendString:ide];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamAlbumsResponseModel* model = [TeamAlbumsResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取相册详情
- (NSURLSessionTask *)fetchAlbumDetail:(NSInteger)albumId offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    {
        [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
        NSMutableString* URL = [[NSMutableString alloc] init];
        [URL appendString:AlbumDetail];
        NSDictionary *para = @{@"id":@(albumId),@"offset":@(offset)};
        return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            AlbumDetailResponseModel* model = [AlbumDetailResponseModel mj_objectWithKeyValues:responseObject];
            successBlock(model.resp);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
    }
}

//获取球队详情

- (NSURLSessionTask *)fetchTeamDetailInfo:(NSString *)ide token:(NSString*)token from:(long long)from to:(long long)to success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:TeamDetailInfo
     ];
    [URL appendString:ide];
    NSDictionary* dic;
    if (from == 0) {
        dic = @{@"token":token};
    }
    else
    {
        dic = @{@"token":token,@"from":@(from),@"to":@(to)};
    }
    return [self GET:URL parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamInfoResponseModel* model = [TeamInfoResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取球员信息
-(NSURLSessionTask *)fetchPlayerInfo:(NSString *)playerId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:PlayerInfo
     ];
    [URL appendString:playerId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PlayerInforesponseModel* model = [PlayerInforesponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取教练信息
- (NSURLSessionTask *)fetchCoachInfo:(NSString *)coachId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/coach/info/"
     ];
    [URL appendString:coachId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [CoachModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"newses":@"newes"};
        }];
        CoachInfoResponseModel* model = [CoachInfoResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//关注球员
- (NSURLSessionTask *)postLikePlayer:(NSString *)playerId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:LikePlyer
     ];
    [URL appendString:playerId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//关注球队
- (NSURLSessionTask *)postLikeTeam:(NSString *)teamId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:likeTeam
     ];
    [URL appendString:teamId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//关注赛事
- (NSURLSessionTask *)postLikeTournament:(NSString *)tournamentId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:likeGame
     ];
    [URL appendString:tournamentId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//关注教练
- (NSURLSessionTask *)postLikeCoach:(NSString *)coachId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:LikeCoach
     ];
    [URL appendString:coachId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//取消关注球员
- (NSURLSessionTask *)postdisLikePlayer:(NSString *)playerId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:disLikePlayer
     ];
    [URL appendString:playerId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//取消关注赛事
- (NSURLSessionTask *)postdisLikeTournament:(NSString *)tournamentId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:disLikegame
     ];
    [URL appendString:tournamentId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//取消关注球队
- (NSURLSessionTask *)postdisLikeTeam:(NSString *)teamId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:dislikeTeam
     ];
    [URL appendString:teamId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

//取消关注教练
- (NSURLSessionTask *)postdislikeCoach:(NSString *)fansId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/user/removeFansCoach/"
     ];
    [URL appendString:fansId];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//获取赛事简介
- (NSURLSessionTask *)fetchGameInfo:(NSString *)tournamentId token:(NSString*)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameInfo];
    [URL appendString:tournamentId];
    NSDictionary* dic = @{@"token":token};
    return [self GET:URL parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [GameInfoModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        GameInfoResponseModel* model = [GameInfoResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取赛程
- (NSURLSessionTask *)fetchGameSchedule:(NSString *)tournamentId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameSchedule];
    [URL appendString:tournamentId];
    NSDictionary* dic = @{@"group":@YES};
    return [self GET:URL parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [Games mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        TournamentGamesResponseModel* model = [TournamentGamesResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取赛事球队
- (NSURLSessionTask *)fetchGameTeams:(NSString *)tournamentId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameTeams];
    [URL appendString:tournamentId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TeamResponseModel* model = [TeamResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取比赛新闻
- (NSURLSessionTask *)fetchGameNews:(NSString *)matchId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameNews];
    [URL appendString:matchId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameNewsDetailResponseModel* model = [GameNewsDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取比赛详情
- (NSURLSessionTask *)fetchGameDetail:(NSString *)matchId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameDetails];
    [URL appendString:matchId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameDetailResponseModel1* model = [GameDetailResponseModel1 mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取比赛留言
- (NSURLSessionTask *)fetchGameMessage:(NSString *)matchId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:GameMessage];
    [URL appendString:matchId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GameMessageResponseModel* result = [GameMessageResponseModel mj_objectWithKeyValues:responseObject];
        NSArray<NewsDetailModel*>* model = result.resp;
        NSMutableArray<Comments*>* array =[[NSMutableArray alloc] init];
        [model enumerateObjectsUsingBlock:^(NewsDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array appendObjects:obj.comments];
        }];
        NSArray* result1 = [[NSArray alloc] initWithArray:array];
        successBlock(result1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取球员数据
- (NSURLSessionTask *)fetchPlayerData:(NSString *)playerId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/player/data/"
     ];
    [URL appendString:playerId];
    NSDictionary* para = @{@"token":token};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PlayerDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        PlayerDataResponseModel* model = [PlayerDataResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取教练数据
- (NSURLSessionTask *)fetchCoachData:(NSString *)coachId token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/coach/data/"
     ];
    [URL appendString:coachId];
    NSDictionary* para = @{@"token":token};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PlayerDetail mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        CoachDataResponseModel* model = [CoachDataResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取积分榜
- (NSURLSessionTask *)fetchScoreList:(NSString *)tournamentid success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/tournament/pointTable/"
     ];
    [URL appendString:tournamentid];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        ScoreListResponseModel* model = [ScoreListResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取射手榜
- (NSURLSessionTask *)fetchScorerList:(NSString *)tournamentid success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/tournament/scorerTable/"
     ];
    [URL appendString:tournamentid];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ScorerListResponseModel* model = [ScorerListResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取奖项列表
- (NSURLSessionTask *)fetchAwardList:(NSString *)tournamentid success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/tournament/results/"
     ];
    [URL appendString:tournamentid];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        AwardListResponseModel* model = [AwardListResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取比赛数据
- (NSURLSessionTask *)fetchRaceData:(NSString *)matchId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/history/"
     ];
    [URL appendString:matchId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        RaceDataResponseModel* model = [RaceDataResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取比赛赛况
- (NSURLSessionTask *)fetchRaceEvents:(NSString *)matchId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/events/"
     ];
    [URL appendString:matchId];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MatchEventResponseModel* model = [MatchEventResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取约战列表
- (NSURLSessionTask *)fetchInvitations:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/invitations"
     ];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [InvitationModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        InvitationResponseModel* model = [InvitationResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取我的约战
- (NSURLSessionTask *)fetchMyInvitations:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/myInvitations"
     ];
    NSDictionary* para = @{@"token":token};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [InvitationModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        MyInvitationResponseModel* model = [MyInvitationResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取我的已关闭约战
- (NSURLSessionTask *)fetchMyClosedInvitations:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/myClosedInvitations"
     ];
    NSDictionary* para = @{@"token":token};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [InvitationModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"desc":@"description"};
        }];
        MyClosedInvitationResponseModel* model = [MyClosedInvitationResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取球场列表
- (NSURLSessionTask *)fetchPlaceList:(NSString *)schoolCode success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/"
     ];
    [URL appendString:schoolCode];
    [URL appendString:@"/match/stadiums"];
    return [self GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PlacceResponseModel* model = [PlacceResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//上传约战
- (NSURLSessionTask *)postInvitation:(NSString *)title date:(long long)date stadium:(NSInteger)stadium type:(NSString *)type contact:(NSString *)contact linkman:(NSString *)linkman description:(NSString *)description token:(NSString *)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/match/updateInvitation"];
    NSDictionary* para = @{@"title":title,@"date":@(date),@"stadium":@(stadium),@"type":type,@"contact":contact,@"linkman":linkman,@"description":description,@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取关注新闻
- (NSURLSessionTask *)fetchMyFans:(NSString *)token offset:(NSInteger)offset success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/user/fansNews"];
    NSDictionary* para = @{@"token":token,@"offset":@(offset)};
    return [self GET:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsModel *model = [NewsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//修改昵称
- (NSURLSessionTask *)changeNickName:(NSString *)token name:(NSString *)nickName success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    NSMutableString* URL = [[NSMutableString alloc] init];
    [URL appendString:@"/user/info/"];
    [URL appendString:nickName];
    NSDictionary* para = @{@"token":token};
    return [self POST:URL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//获取热点详情
- (NSURLSessionTask *)fetchHotDetail:(NSString *)newsId success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableString* string = [NSMutableString stringWithString: @"/news/hotTopicDetail/"];
    [string appendString:newsId];
    return [self GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewsDetailResponseModel* model = [NewsDetailResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//上传头像
- (NSURLSessionTask *)postImage:(NSString *)base64 token:(NSString*)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableString* string = [NSMutableString stringWithString: @"/media/uploadImage"];
    NSDictionary* para = @{@"str":base64,@"token":token};
    return [self POST:string parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ImageResponseModel* model = [ImageResponseModel mj_objectWithKeyValues:responseObject];
        successBlock(@(model.resp.id));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//更新我的头像
- (NSURLSessionTask *)updateMyAvatar:(NSInteger)pictureId token:(NSString*)token success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableString* string = [NSMutableString stringWithString: @"/user/updateMyAvatar"];
    NSDictionary* para = @{@"id":@(pictureId),@"token":token};
    return [self POST:string parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end

