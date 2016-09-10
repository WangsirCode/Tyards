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
@property (nonatomic, strong) TeamHomeModel    *model;
@property (nonatomic, strong) TeamPlayerModel1 *players;
@property (nonatomic, strong) NSArray<Comments*> *comments;
@property (nonatomic,strong ) RACCommand       * shareCommand;
@property (nonatomic,strong ) RACCommand       * likeCommand;
@property (nonatomic,assign ) NSInteger        loadingStatus;
@property (nonatomic, strong) NSArray<GameDetailModel*> *games;
@property (nonatomic, strong) TeamInfoModel    *InfoModel;
@property (nonatomic,assign ) BOOL             fan;
@property (nonatomic,assign ) BOOL             didFaned;
@property (nonatomic,strong) NSArray*          pickerViewDataSource;
@property (nonatomic,assign) NSInteger          pickerIndex;
@property (nonatomic,assign) BOOL   shouldUpdateRecord;
@property (nonatomic,assign) BOOL   shouldUpdateList;
@property (nonatomic,assign) BOOL   shouldUpdateSchedule;
@property (nonatomic,strong) NSString * teamId;
- (void)loadSchedule:(NSString*)fromDate;
- (void)loadList:(NSString*)fromDate;
- (void)loadSRecord:(NSString*)formDate;
@end
