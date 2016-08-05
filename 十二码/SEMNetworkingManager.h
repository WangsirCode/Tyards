//
//  SEMNetworkingManager.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

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
@end

