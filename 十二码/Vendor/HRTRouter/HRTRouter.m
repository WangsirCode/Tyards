//
//  HRTRouter.m
//  DuoDuoNews
//
//  Created by Hirat on 16/5/26.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "HRTRouter.h"
#import <JLRoutes.h>
#import <MGJRouter.h>
#import "MMDrawerController.h"
#import "SEMTabViewController.h"
@interface HRTRouter ()
@property (nonatomic, strong) NSMutableDictionary* routeMap;
@end

@implementation HRTRouter

+ (instancetype)sharedInstance
{
    static HRTRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [HRTRouter sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [HRTRouter sharedInstance];
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(id (^)(NSDictionary *parameters))handler
{
    [MGJRouter registerURLPattern: URLPattern toObjectHandler: handler];
    
    [JLRoutes addRoute: URLPattern handler:^BOOL(NSDictionary * _Nonnull routeParameters) {
        
        NSDictionary* mgjRouterParameters = @{MGJRouterParameterURL: routeParameters[kJLRoutePatternKey],
                                              MGJRouterParameterUserInfo: routeParameters};
        UIViewController* toObject = handler(mgjRouterParameters);
        toObject.hidesBottomBarWhenPushed = YES;
        NSLog(@"%@", toObject);
        
        UIViewController* root = [UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController* nav;
        if ([root isKindOfClass: [UITabBarController class]])
        {
            UITabBarController* tabBar = (UITabBarController*)root;
            nav = tabBar.selectedViewController;
        }
        else if ([root isKindOfClass: [UINavigationController class]])
        {
            nav = (UINavigationController*)root;
        }
        else if ([root isKindOfClass: [MMDrawerController class]])
        {
            SEMTabViewController *center = (SEMTabViewController*)((MMDrawerController*)root).centerViewController;
            nav = center.selectedViewController;
        }
        else
        {
            NSLog(@"暂时不处理");
        }
        
        if ([nav isKindOfClass: [UINavigationController class]])
        {
            [nav pushViewController: toObject animated: YES];
        }
        else
        {
            NSLog(@"什么鬼");
        }
        
        return YES;
        
    }];
}

+ (BOOL)openURL:(NSURL *)URL withParameters:(NSDictionary *)parameters
{
    BOOL open = [JLRoutes routeURL: URL withParameters: parameters];
    
    if (!open)
    {
        NSString* route = [[URL.absoluteString componentsSeparatedByString: @"?"] firstObject];
        if ([[HRTRouter sharedInstance].routeMap.allKeys containsObject: route])
        {
            [HRTRouter map: route toTarget: [HRTRouter sharedInstance].routeMap[route]];
        }
        
        open = [JLRoutes routeURL: URL withParameters: parameters];
    }
    return open;
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo
{
    id object = [MGJRouter objectForURL: URL withUserInfo: userInfo];
    
    if (!object)
    {
        NSString* route = [[URL componentsSeparatedByString: @"?"] firstObject];
        if ([[HRTRouter sharedInstance].routeMap.allKeys containsObject: route])
        {
            [HRTRouter map: route toTarget: [HRTRouter sharedInstance].routeMap[route]];
        }
        
        object = [MGJRouter objectForURL: URL withUserInfo: userInfo];
    }
    
    return object;
}

+ (id)objectForURL:(NSString *)URL
{
    return [HRTRouter objectForURL: URL withUserInfo: nil];
}

+ (BOOL)openURL:(NSURL *)URL
{
    return [HRTRouter openURL: URL withParameters: nil];
}

+ (void)map:(NSString*)route toTarget:(NSString*)targetName
{
    [UIViewController registerRoute: route toObjectHandler:^id(NSDictionary *parameters) {
        
        Class targetClass = NSClassFromString(targetName);
        id target = [[targetClass alloc] init];
        if ([target isKindOfClass:[UIViewController class]])
        {
            UIViewController* viewController = (UIViewController*)target;
            NSDictionary* routerParameters;
            if ([parameters.allKeys containsObject: MGJRouterParameterUserInfo])
            {
                routerParameters = parameters[MGJRouterParameterUserInfo];
            }
            else
            {
                routerParameters = parameters;
            }
            
            viewController.routerParameters = routerParameters;
            if ([parameters.allKeys containsObject: @"navigation"])
            {
                Class navigationClass = NSClassFromString([HRTRouter sharedInstance].routeMap[parameters[@"navigation"]]);
                UIViewController* navigation = [[navigationClass alloc] initWithRootViewController: viewController];
                return navigation;
            }
            
            return viewController;
        }
        else
        {
            return nil;
        }
        
    }];
}

#pragma mark - Set/Get

- (NSMutableDictionary*)routeMap
{
    if (!_routeMap)
    {
        _routeMap = [NSMutableDictionary dictionary];
    }
    
    return _routeMap;
}

@end
