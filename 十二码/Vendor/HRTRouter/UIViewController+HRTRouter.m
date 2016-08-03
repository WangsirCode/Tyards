//
//  UIViewController+HRTRouter.m
//  DuoDuoNews
//
//  Created by Hirat on 16/5/26.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "UIViewController+HRTRouter.h"
#import <objc/runtime.h>
#import "HRTRouter.h"

@implementation UIViewController (HRTRouter)

static char kAssociatedObjectRouterParametersKey;

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    objc_setAssociatedObject(self, &kAssociatedObjectRouterParametersKey, routerParameters,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary*)routerParameters
{
    return objc_getAssociatedObject(self, &kAssociatedObjectRouterParametersKey);
}

+ (void)registerRoute:(NSString*)routePattern toObjectHandler:(id (^)(NSDictionary *parameters))handler
{
    [HRTRouter registerURLPattern: routePattern toObjectHandler: handler];
}

@end
