//
//  SEMTeamHomeModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "TeamHomeModelResponse.h"
#import "TeamPlayerResponseModel.h"
#import "NewsDetailViewModel.h"
#import "GameDetailModel.h"
@interface SEMTeamHomeModel : SEMViewModel
@property (nonatomic, strong) TeamHomeModel   *model;
@property (nonatomic, strong) NSArray<TeamPlayerModel *> *players;
@property (nonatomic, strong) NSArray<Comments        *> *comments;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@property (nonatomic,assign ) NSInteger       loadingStatus;
@property (nonatomic, strong) NSArray<GameDetailModel *> *games;
@property (nonatomic, strong) TeamInfoModel *InfoModel;
@end
