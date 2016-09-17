//
//  SEMNetworkingManager.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "ImageResponseModel.h"
#import <AFNetworking/AFNetworking.h>
#import "hotTopicsModel.h"
#import "DataArchive.h"
#import "ReCommendNews.h"
#import "SearchModel.h"
#import "SearchResultsModel.h"
#import "News.h"
#import "TopicModel.h"
@interface SEMNetworkingManager : AFHTTPSessionManager
/**
 *  网络模块单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/*!
 *  @author 汪宇豪, 16-07-22 16:07:43
 *
 *  @brief 获取热点
 *
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchHotTopics:(NSString*)code
                            success:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-07-23 09:07:43
 *
 *  @brief 获取推荐
 *
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchReCommendNews:(NSString*)code
                                 offset:(NSInteger)offset
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-07-24 20:07:05
 *
 *  @brief 获取学习区域列表
 *
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchSchoolList:(void (^)(id data))successBlock
                                failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-07-24 20:07:37
 *
 *  @brief 获取搜索结果
 *
 *  @param name         搜索字段
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchSearchResults:(NSString*)name
                                success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-25 13:07:16
 *
 *  @brief 获取新闻列表
 *
 *  @param name         学校
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchNews:(NSString*)name
                                 offset:(NSInteger)offset
                                success:(void (^)(id data))successBlock
                                failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-25 14:07:12
 *
 *  @brief 获取话题
 *
 *  @param name         学校
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTopics:(NSString*)name
                        offset:(NSInteger)offset
                       success:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-27 11:07:30
 *
 *  @brief 获取比赛预告
 *
 *  @param schoolCode   学校code
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchNoticeGame:(NSString*)schoolCode
                          offset:(NSInteger)offset
                         success:(void (^)(id data))successBlock
                         failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-07-27 11:07:16
 *
 *  @brief 获取比赛历史信息
 *
 *  @param schoolCode   学校code
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchHistoryGame:(NSString*)schoolCode
                              offset:(NSInteger)offset
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-27 14:07:00
 *
 *  @brief 获取赛事列表
 *
 *  @param schoolCode   学校code
 *  @param offset       偏移
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameList:(NSString*)schoolCode
                               offset:(NSInteger)offset
                              success:(void (^)(id data))successBlock
                              failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-07-27 16:07:49
 *
 *  @brief 获取新闻详情
 *
 *  @param id           新闻id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchNewsDetail:(NSInteger)ide
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-28 11:07:08
 *
 *  @brief 请求token
 *
 *  @param token        token
 *  @param openid       openid
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchWexinToken:(NSString*)token
                                  openid:(NSString*)openid
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-07-28 11:07:22
 *
 *  @brief 请求token
 *
 *  @param token        token
 *  @param openid       opeind
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchQQToken:(NSString*)token
                              openid:(NSString*)openid
                             success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-05 09:08:50
 *
 *  @brief 获取球队列表
 *
 *  @param name         球队名称
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamList:(NSString*)schoolcode
                        searchName:(NSString*)name
                          success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;



/*!
 *  @author 汪宇豪, 16-08-05 11:08:55
 *
 *  @brief 获取球队信息
 *
 *  @param ide          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamInfo:(NSString*)ide
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-05 16:08:56
 *
 *  @brief 获取队员信息
 *
 *  @param ide          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamPlayers:(NSString*)ide
                                 from:(long long)from
                                   to:(long long)to
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-05 18:08:43
 *
 *  @brief 获取球队评论
 *
 *  @param ide          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamComments:(NSString*)ide
                              success:(void (^)(id data))successBlock
                              failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-06 09:08:06
 *
 *  @brief 获取球队赛程
 *
 *  @param ide          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamGames:(NSString*)ide
                               from:(long long)from
                                 to:(long long)to
                               success:(void (^)(id data))successBlock
                               failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-09 20:08:46
 *
 *  @brief 获取球队信息
 *
 *  @param ide          ide
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)fetchTeamDetailInfo:(NSString*)ide
                                   token:(NSString*)token
                                    from:(long long)from
                                      to:(long long)to
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-06 20:08:40
 *
 *  @brief 获取个人信息
 *
 *  @param ide          token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchUserInfo:(NSString*)token
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-06 23:08:08
 *
 *  @brief 获取学院列表
 *
 *  @param ide          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchColleges:(NSString*)ide
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;



/*!
 *  @author 汪宇豪, 16-08-07 00:08:55
 *
 *  @brief 更新用户信息
 *
 *  @param schoolId     学校id
 *  @param collegeId    学院id
 *  @param gender       性别
 *  @param birthday     生日
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postUserInfo:(NSInteger)schoolId
                        collegeId:(NSInteger)collegeId
                           gender:(NSString*)gender
                         birthday:(long long) birthday
                            token:(NSString*)token
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-07 00:08:57
 *
 *  @brief 获取我的评论信息
 *
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchMyReplies:(NSString*)token
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-07 01:08:00
 *
 *  @brief 获取我的关注
 *
 *  @param ids          id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchMyConcern:(NSString*)ids
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-08 14:08:03
 *
 *  @brief 提交反馈
 *
 *  @param feedback     成功
 *  @param successBlock 失败
 *  @param failureBlock
 *
 *  @return 
 */
- (NSURLSessionTask*)postFeebback:(NSString*)feedback
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-09 09:08:37
 *
 *  @brief 获取球队相册
 *
 *  @param teamId       球队id
 *  @param successBlock 层共
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchTeamAlbums:(NSString*)teamId
                          success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-09 09:08:16
 *
 *  @brief 获取相册详情
 *
 *  @param teamId       相册id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchAlbumDetail:(NSInteger)albumId
                               offset:(NSInteger)offset
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;



/*!
 *  @author 汪宇豪, 16-08-10 09:08:56
 *
 *  @brief 获取球员信息
 *
 *  @param playerId     球员id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchPlayerInfo:(NSString*)playerId
                              success:(void (^)(id data))successBlock
                              failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-29 14:08:22
 *
 *  @brief 获取教练信息
 *
 *  @param coachId      coachId
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchCoachInfo:(NSString*)coachId
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-14 18:08:23
 *
 *  @brief 获取球员数据
 *
 *  @param playerId     球员id
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchPlayerData:(NSString*)playerId
                               token:(NSString*)token
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-29 14:08:30
 *
 *  @brief 获取教练资料
 *
 *  @param coachId      教练id
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchCoachData:(NSString*)coachId
                               token:(NSString*)token
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;
/*!
 
 *  @author 汪宇豪, 16-08-10 16:08:40
 *
 *  @brief 关注球员
 *
 *  @param playerId     <#playerId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postLikePlayer:(NSString*)playerId
                              token:(NSString*)token
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-10 16:08:58
 *
 *  @brief 取消关注球员
 *
 *  @param playerId     <#playerId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postdisLikePlayer:(NSString*)playerId
                              token:(NSString*)token
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-08-10 16:08:09
 *
 *  @brief 关注球队
 *
 *  @param teamId       <#teamId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postLikeTeam:(NSString*)teamId
                              token:(NSString*)token
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-10 16:08:41
 *
 *  @brief 取消关注球队
 *
 *  @param teamId       <#teamId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postdisLikeTeam:(NSString*)teamId
                            token:(NSString*)token
                          success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-10 16:08:58
 *
 *  @brief 关注赛事
 *
 *  @param tournamentId <#tournamentId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postLikeTournament:(NSString*)tournamentId
                            token:(NSString*)token
                          success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;
/*!
 *  @author 汪宇豪, 16-08-10 16:08:57
 *
 *  @brief 取消关注赛事
 *
 *  @param tournamentId <#tournamentId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postdisLikeTournament:(NSString*)tournamentId
                                  token:(NSString*)token
                                success:(void (^)(id data))successBlock
                                failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-10 16:08:34
 *
 *  @brief 关注教练
 *
 *  @param tournamentId <#tournamentId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postLikeCoach:(NSString*)coachId
                                  token:(NSString*)token
                                success:(void (^)(id data))successBlock
                                failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-10 16:08:52
 *
 *  @brief 取消关注教练
 *
 *  @param coachId      <#coachId description#>
 *  @param token        <#token description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionTask*)postdislikeCoach:(NSString*)fansId
                             token:(NSString*)token
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;



/*!
 *  @author 汪宇豪, 16-08-10 17:08:12
 *
 *  @brief 获取赛事简介
 *
 *  @param tournamentId 赛事id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameInfo:(NSString*)tournamentId
                             token:(NSString*)token
                              success:(void (^)(id data))successBlock
                              failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-11 09:08:26
 *
 *  @brief 获取赛程
 *
 *  @param tournamentId id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameSchedule:(NSString*)tournamentId
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-11 09:08:51
 *
 *  @brief 获取赛事的球队
 *
 *  @param tournamentId id
 *  @param successBlock 成功
 *  @param failureBlock 是吧
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameTeams:(NSString*)tournamentId
                               success:(void (^)(id data))successBlock
                               failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-11 10:08:01
 *
 *  @brief 获取比赛的新闻
 *
 *  @param matchId      比赛id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameNews:(NSString*)matchId
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-11 10:08:10
 *
 *  @brief 获取比赛详情
 *
 *  @param matchId      id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameDetail:(NSString*)matchId
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-11 11:08:46
 *
 *  @brief 获取比赛留言
 *
 *  @param matchId      id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchGameMessage:(NSString*)matchId
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-23 10:08:03
 *
 *  @brief 获取积分榜
 *
 *  @param tournamentid 赛事ID
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchScoreList:(NSString*)tournamentid
                              success:(void (^)(id data))successBlock
                              failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-08-23 11:08:15
 *
 *  @brief 获取射手榜
 *
 *  @param tournamentid 赛事ID
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchScorerList:(NSString*)tournamentid
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-23 11:08:16
 *
 *  @brief 获取奖项
 *
 *  @param tournamentid 赛事ID
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchAwardList:(NSString*)tournamentid
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-27 21:08:08
 *
 *  @brief 获取比赛数据
 *
 *  @param matchId      matchId
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchRaceData:(NSString*)matchId
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-28 14:08:34
 *
 *  @brief 获取赛况
 *
 *  @param matchId      matchId
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchRaceEvents:(NSString*)matchId
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-29 23:08:48
 *
 *  @brief 获取约战列表
 *
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchInvitations:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-30 19:08:55
 *
 *  @brief 获取我的约战
 *
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchMyInvitations:(NSString*)token
                             success:(void (^)(id data))successBlock
                             failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-30 19:08:30
 *
 *  @brief 获取我的已关闭的约战
 *
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchMyClosedInvitations:(NSString*)token
                                success:(void (^)(id data))successBlock
                                failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-31 09:08:44
 *
 *  @brief 获取球场列表
 *
 *  @param schoolCode   schoolCode
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchPlaceList:(NSString*)schoolCode
                                      success:(void (^)(id data))successBlock
                                      failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-08-31 14:08:06
 *
 *  @brief 发送约战
 *
 *  @param title        标题
 *  @param date         日期
 *  @param stadium      场馆
 *  @param type         类型
 *  @param contact      联系方式
 *  @param linkman      联系人
 *  @param description  附加信息
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postInvitation:(NSString*)title
                               date:(long long)date
                            stadium:(NSInteger)stadium
                               type:(NSString*)type
                            contact:(NSString*)contact
                            linkman:(NSString*)linkman
                        description:(NSString*)description
                              token:(NSString*)token
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-09-03 09:09:07
 *
 *  @brief 获取关注新闻
 *
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchMyFans:(NSString*)token
                          offset:(NSInteger)offset
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-03 17:09:04
 *
 *  @brief 修改昵称
 *
 *  @param token        token
 *  @param nickName     昵称
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)changeNickName:(NSString*)token
                          name:(NSString*)nickName
                         success:(void (^)(id data))successBlock
                         failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-09-08 22:09:52
 *
 *  @brief 获取热点详情
 *
 *  @param newsId       newsId
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchHotDetail:(NSString*)newsId
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-10 21:09:25
 *
 *  @brief 上传图片
 *
 *  @param base64
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postImage:(NSString*)base64
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-10 21:09:28
 *
 *  @brief 更新头像
 *
 *  @param pictureId    id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)updateMyAvatar:(NSInteger)pictureId
                              token:(NSString*)token
                       success:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock;



/*!
 *  @author 汪宇豪, 16-09-14 09:09:53
 *
 *  @brief 提交评论
 *
 *  @param iden            新闻id
 *  @param content         内容
 *  @param targetCommentId 回复的评论的id
 *  @param remind          回复的人的id
 *  @param token           toekn
 *  @param successBlock    成功
 *  @param failureBlock    失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postComment:(NSInteger)iden
                         content:(NSString*)content
                 targetCommentId:(NSInteger)targetCommentId
                          remind:(NSInteger)remind
                              token:(NSString*)token
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-09-15 23:09:29
 *
 *  @brief 评论热点
 *
 *  @param iden            热点id
 *  @param content         内容
 *  @param targetCommentId 回复的评论的id
 *  @param remind          回复的人的id
 *  @param token           token
 *  @param successBlock    成功
 *  @param failureBlock    失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)commentHottopic:(NSInteger)iden
                         content:(NSString*)content
                 targetCommentId:(NSInteger)targetCommentId
                          remind:(NSInteger)remind
                           token:(NSString*)token
                         success:(void (^)(id data))successBlock
                         failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-09-14 20:09:11
 *
 *  @brief 获取球员的互动信息
 *
 *  @param playerId     球员id
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchPlayerNews:(NSString*)playerId
                            success:(void (^)(id data))successBlock
                            failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-15 08:09:08
 *
 *  @brief 添加球队说说
 *
 *  @param teamId       球队id
 *  @param content      内容
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postTeamNews:(NSString*)teamId
                         content:(NSString*)content
                           images:(NSString*)images
                           token:(NSString*)token
                         success:(void (^)(id data))successBlock
                         failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-15 22:09:55
 *
 *  @brief 添加赛事互动
 *
 *  @param teamId       赛事id
 *  @param content      说说内容
 *  @param images       图片
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postMatchNews:(NSString*)matchId
                          content:(NSString*)content
                           images:(NSString*)images
                            token:(NSString*)token
                          success:(void (^)(id data))successBlock
                          failure:(void (^)(NSError *aError))failureBlock;

/*!
 *  @author 汪宇豪, 16-09-15 22:09:21
 *
 *  @brief 添加教练新闻
 *
 *  @param coachId      教练id
 *  @param content      内容
 *  @param images       图片
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postCoachNews:(NSString*)coachId
                           content:(NSString*)content
                            images:(NSString*)images
                             token:(NSString*)token
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;


/*!
 *  @author 汪宇豪, 16-09-15 22:09:30
 *
 *  @brief 添加球员新闻
 *
 *  @param playerId     球员id
 *  @param content      内容
 *  @param images       图片
 *  @param token        token
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)postPlayerNews:(NSString*)playerId
                           content:(NSString*)content
                            images:(NSString*)images
                             token:(NSString*)token
                           success:(void (^)(id data))successBlock
                           failure:(void (^)(NSError *aError))failureBlock;

@end

