//
//  PlayerDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface PlayerDetailViewModel : SEMViewModel
@property (nonatomic, strong) PlayerModel     *model;
@property (nonatomic, strong) NSArray<NewsDetailModel *> *messageModel;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@property (nonatomic, strong) PlayerDataModel *palyerData;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) BOOL fan;
@property (nonatomic,assign) BOOL didFaned;
@end
