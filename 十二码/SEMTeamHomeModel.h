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
@interface SEMTeamHomeModel : SEMViewModel
@property (nonatomic, strong) TeamHomeModel *model;
@property (nonatomic, strong) NSArray<TeamPlayerModel *> *players;
@property (nonatomic,strong)RACCommand* shareCommand;
@property (nonatomic,strong)RACCommand* likeCommand;
@property (nonatomic,assign)BOOL finishenLoading;
@end
