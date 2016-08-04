//
//  MDABizManager.h
//  MediaAssistant
//
//  Created by Hirat on 16/7/7.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ReactiveCocoa.h"
#import "YYCategories.h"
#import "HRTRouter.h"
#import "DataArchive.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SEMNetworkingManager.h"
#import "XHToast.h"
#import "SDAutoLayout.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MBProgressHUD.h"
#import "UIView+Scale.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "UITableViewCell+Scale.h"
@interface MDABizManager : NSObject
@property (nonatomic,assign)BOOL userLogined;
/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;
- (void)updataUserLoginInfo;

@end
