//
//  HRTRouter.h
//  DuoDuoNews
//
//  Created by Hirat on 16/5/26.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+HRTRouter.h"
#import <MGJRouter.h>
#import <JLRoutes.h>

/**
 *  URL 总线
 */

@interface HRTRouter : NSObject

/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  路由表
 */
@property (nonatomic, strong, readonly) NSMutableDictionary* routeMap;

/**
 *  路由表
 *
 *  @param route      路由
 *  @param targetName Controller名称
 */
+ (void)map:(NSString*)route toTarget:(NSString*)targetName;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 hrt://beauty/3
 *
 *  @return 是否可以打开
 */
+ (BOOL)openURL:(NSURL *)URL;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL        带 Scheme，如 hrt://beauty/3
 *  @param parameters 参数
 *
 *  @return 是否可以打开
 */
+ (BOOL)openURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;


/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param URLPattern 带上 scheme，如 hrt://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 hrt://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(id (^)(NSDictionary *parameters))handler;

/**
 *  查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL URL
 *
 *  @return object
 */
+ (id)objectForURL:(NSString *)URL;

/**
 *  查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL      URL
 *  @param userInfo userInfo
 *
 *  @return object
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

@end
