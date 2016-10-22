//
//  AppDelegate.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeChatUserModel.h"
@protocol WechatDelegate <NSObject>
- (void)didGetUserInfo:(WeChatUserModel*)info;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) NSString* nickName;
@end

