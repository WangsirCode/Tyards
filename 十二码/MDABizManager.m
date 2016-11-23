//
//  MDABizManager.m
//  MediaAssistant
//
//  Created by Hirat on 16/7/7.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "MDABizManager.h"
#import "HRTRouter.h"

@implementation MDABizManager

+ (void)load
{
    NSDictionary* routeMap = @{@"Home": @"SEMHomeVIewController",
                               @"Team":@"SEMTeamViewController",
                               @"Game":@"SEMGameViewController",
                               @"Me":@"SEMMeViewController",
//                               @"News":@"SEMNewsViewController",
                               @"News":@"WateringVC",
                               @"initial": @"SEMInitialViewController",
                               @"navigation": @"SEMNavigationController",
                               @"tab":@"SEMTabViewController",
                               @"search":@"SEMSearchViewController",
                               @"login":@"SEMLoginViewController",
                               @"Newsdetail":@"SEMNewsDetailController",
                               @"photo":@"SEMTeamPhotoController",
//                               @"myInfo":@"PersonalInfoController",
                               @"myInfo":@"MyZone",
                               @"myArticle":@"MyArticle",
                               @"MEInfoColleageSearch":@"ColleageSearchController",
                               @"Myconcern":@"MyConcernController",
                               @"MyMessage":@"MyMessageController",
                               @"setup":@"SetUpController",
                               @"feedBack":@"FeedBackController",
                               @"about":@"AboutViewController",
                               @"TeamHome":@"SEMTeamHomeViewController"};
    [[HRTRouter sharedInstance].routeMap addEntriesFromDictionary: routeMap];
}

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return _sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [MDABizManager sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [MDABizManager sharedInstance];
}
- (void)updataUserLoginInfo
{
    self.userLogined = YES;
}

@end
