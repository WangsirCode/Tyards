//
//  SEMGameVIewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "GameListResponseModel.h"
#import "GameDetailModel.h"
@interface SEMGameVIewModel : SEMViewModel
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong ) RACCommand * loadNewNoticeGameCommand;
@property (nonatomic,strong ) RACCommand * loadMoreNoticeGameCommad;
@property (nonatomic,strong ) RACCommand * loadNewHistoryGameCommand;
@property (nonatomic,strong ) RACCommand * loadMoreHistoryGameCommand;
@property (nonatomic,strong ) RACCommand * loadNewGameListCommand;
@property (nonatomic,strong ) RACCommand * loadMoreGameListCommand;
@property (nonatomic, strong) NSArray<GameDetailModel *> * noticeGameDatasource;
@property (nonatomic, strong) NSArray<GameDetailModel *> * historyGameDatasource;
@property (nonatomic, strong) NSArray<GameListModel *> *gameListDatasource;
@property (nonatomic,strong) NSString* code;
@property (nonatomic,assign) BOOL fisrtGotoHistoryTable;
@property (nonatomic,assign) BOOL fisrtGotoGameListtable;
@property (nonatomic,assign) NSInteger historyGameCount;
@property (nonatomic,assign) NSInteger niticeGameCount;
@end
