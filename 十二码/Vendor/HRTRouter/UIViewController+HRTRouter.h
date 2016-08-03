//
//  UIViewController+HRTRouter.h
//  DuoDuoNews
//
//  Created by Hirat on 16/5/26.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HRTRouter)

/**
 *  通过 url 配置参数
 */
@property (nonatomic, strong) NSDictionary* routerParameters;

/**
 *  注册 route，返回 ViewController
 *
 *  @param routePattern routePatter
 *  @param handler      参数
 */
+ (void)registerRoute:(NSString*)routePattern toObjectHandler:(id (^)(NSDictionary *parameters))handler;

@end
