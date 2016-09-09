//
//  HistoryView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
#import "HistoryInfoView.h"
@class PlayHistory;
@interface HistoryView : UIView
@property (nonatomic, strong) NSArray<PlayHistory *> *history;
@end
