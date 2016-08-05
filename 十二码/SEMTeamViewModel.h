//
//  SEMTeamViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "TeamLisstResponseModel.h"
@interface SEMTeamViewModel : SEMViewModel
@property (nonatomic,strong) NSString* title;
@property (nonatomic, strong) TeamModel *model;
@property (nonatomic,strong)RACCommand* searchCommand;
@property (nonatomic, strong) TeamModel *teams;
@property (nonatomic,assign)BOOL isSearching;
@property (nonatomic,assign) BOOL needReloadTableview;
@end
