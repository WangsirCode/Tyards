//
//  AppDelegate.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "LoginCommand.h"
#import "AppDelegate.h"
#import "HRTRouter.h"
#import "WXApi.h"
#import "MDABizManager.h"
#import "WeChatUserModel.h"
#import "SEMNetworkingManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UserModel.h"
NSString* const WXPatient_App_ID = @"wx9bdb6c74a8821ee3";
NSString* const WXPatient_App_Secret = @"bda4135fa9aa74b8d4e123713d24b6fb";
NSString* const WX_BASE_URL = @"https://api.weixin.qq.com/sns";
NSString* const WX_ACCESS_TOKEN = @"access_token";
NSString* const WX_OPEN_ID = @"openid";
NSString* const WX_REFRESH_TOKEN = @"refresh_token";
NSString* const USER_INFO = @"userinfo";
@interface AppDelegate ()<WXApiDelegate,TencentSessionDelegate>
@property (nonatomic,retain) id<WechatDelegate> delegate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"wx9bdb6c74a8821ee3"];
    CGFloat scale = [UIScreen mainScreen].bounds.size.width / 375;
    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    [database setFloat:scale forKey:@"scale"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    self.window.rootViewController = [HRTRouter objectForURL: @"initial"];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options{
    /*! @brief 处理微信通过URL启动App时传递的数据 * * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。 * @param url 微信启动第三方应用时传递过来的URL * @param delegate WXApiDelegate对象，用来接收微信触发的消息。 * @return 成功返回YES，失败返回NO。 */
    return [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    
    
    return [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    
    
    return [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];
}
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, WXPatient_App_ID, WXPatient_App_Secret, temp.code];
        [manager.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager GET:accessUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求access的response = %@", responseObject);
            WeChantaccess_tokenModel* model = [WeChantaccess_tokenModel mj_objectWithKeyValues:responseObject];
//            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *accessToken = model.access_token;
            NSString *openID = model.openid;
            NSString *refreshToken = model.refresh_token;
            
            // 本地持久化，以便access_token的使用、刷新或者持续
            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
                SEMNetworkingManager* magager = [SEMNetworkingManager sharedInstance];
                [magager fetchWexinToken:accessToken openid:openID success:^(id data) {
                    NSString* token = data;
                    [DataArchive archiveUserData:token withFileName:@"token"];
                    [self wechatLoginByRequestForUserInfo];
                } failure:^(NSError *aError) {
                    NSLog(@"%@",aError);
                }];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"获取access_token时出错 = %@", error);
        }
         ];
    }
    else if ([resp isKindOfClass:[SendMessageToWXReq class]])
    {
        NSString *str = [NSString stringWithFormat:@"%d",resp.errCode];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertview show];
    }
}
- (void)wechatLoginByRequestForUserInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
    // 请求用户数据
    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WeChatUserModel* model = [WeChatUserModel mj_objectWithKeyValues:responseObject];
        UserModel* data = [[UserModel alloc] init];
        data.headimgurl = model.headimgurl;
        data.nickname = model.nickname;
        data.token = (NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
        [DataArchive archiveUserData:data withFileName:@"userinfo"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData* data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:model.headimgurl]];
            UIImage* imamge = [[UIImage alloc] initWithData:data1];
            [DataArchive archiveUserData:imamge withFileName:@"headimage"];
        });
        LoginCommand* command = [LoginCommand sharedInstance];
        [command.weixinLoginedCommand execute:data];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}

@end
