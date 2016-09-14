//
//  CoachDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface CoachDetailViewModel : SEMViewModel
@property (nonatomic, strong) CoachModel     *model;
@property (nonatomic, strong) NSArray<NewsDetailModel *> *newsModel;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@property (nonatomic, strong) CoachDataModel *palyerData;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) BOOL fan;
@property (nonatomic,assign) BOOL didFaned;
@end
