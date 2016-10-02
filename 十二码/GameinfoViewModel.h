//
//  GameinfoViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "TournamentPolicyResponseModel.h"
@interface GameinfoViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<ScoreListModel *> *scoreModel;
@property (nonatomic, strong) NSArray<ScorerListModel *> *scorerModel;
@property (nonatomic, strong) NSArray<AwardListModel *> *awardModel;
@property (nonatomic, strong) GameInfoModel *model;
@property (nonatomic, strong) NSArray<TournamentGamesModel *> *scheduleModel;
@property (nonatomic, strong) NSArray<MatchTeamModel *> *teamModel;
@property (nonatomic, strong) PolicyModel *policyModel;
@property (nonatomic,assign ) NSInteger     status;
@property (nonatomic,strong ) RACCommand    * shareCommand;
@property (nonatomic,strong ) RACCommand    * likeCommand;
@property (nonatomic,assign) BOOL shouldReloadScheduleTable;
@property (nonatomic,strong) NSArray* infoTableviewRowNumber;
@property (nonatomic,strong) NSArray* infoTableViewCellInfo;
@property (nonatomic,strong) NSArray* infotableviewCellname;
@property (nonatomic,assign) NSInteger listTableIndex;
@property (nonatomic,assign) BOOL fan;
@property (nonatomic,assign) BOOL didFaned;
@property (nonatomic,strong) NSString* teamId;
- (void)loadMoreSchedule;
@end
