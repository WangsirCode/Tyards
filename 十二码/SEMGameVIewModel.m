//
//  SEMGameVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMGameVIewModel.h"
#import "MDABizManager.h"
NSString* const NoticeGameCache = @"NoticeGameCache";
NSString* const HistoryGameCache = @"HistoryGameCache";
NSString* const GameListCache = @"GameListCache";
@implementation SEMGameVIewModel
#pragma mark- initialization
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.title = @"赛事";
        NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
        self.code = [database objectForKey:@"name"];
        self.fisrtGotoGameListtable = YES;
        self.fisrtGotoHistoryTable = YES;
        [self fecthData];
    }
    return self;
}
- (void)fecthData
{
    NSArray *noticeGames = (NSArray*) [DataArchive unarchiveDataWithFileName:NoticeGameCache];
    if (noticeGames.count > 0) {
        self.noticeGameDatasource = noticeGames;
    }
    else
    {
        self.noticeGameDatasource = [[NSArray alloc] init];
    }
    NSArray* historyGames = (NSArray*)[DataArchive unarchiveDataWithFileName:HistoryGameCache];
    if (historyGames.count > 0) {
        self.historyGameDatasource = historyGames;
    }
    else
    {
        self.historyGameDatasource = [[NSArray alloc] init];
    }
    NSArray* gamelists = (NSArray*)[DataArchive unarchiveDataWithFileName:GameListCache];
    if (historyGames.count > 0) {
        self.gameListDatasource = gamelists;
    }
    else
    {
        self.gameListDatasource = [[NSArray alloc] init];
    }
}


#pragma mark- command
- (RACCommand*)loadNewNoticeGameCommand
{
    if (!_loadNewNoticeGameCommand) {
        _loadNewNoticeGameCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchNoticeGame:self.code offset:0 success:^(id data) {
                    self.noticeGameDatasource = data;
                    [DataArchive archiveData:self.noticeGameDatasource withFileName:NoticeGameCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    
    }
    return _loadNewNoticeGameCommand;
}
- (RACCommand*)loadNewHistoryGameCommand
{
    if (!_loadNewHistoryGameCommand) {
        _loadNewHistoryGameCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchHistoryGame:self.code offset:0 success:^(id data) {
                    self.historyGameDatasource = data;
                    [DataArchive archiveData:self.historyGameDatasource withFileName:NoticeGameCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
        self.fisrtGotoHistoryTable = NO;
    }
    return _loadNewHistoryGameCommand;
}
- (RACCommand*)loadNewGameListCommand
{
    if (!_loadNewGameListCommand) {
        _loadNewGameListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchGameList:self.code offset:0 success:^(id data) {
                    self.gameListDatasource = data;
                    [DataArchive archiveData:self.gameListDatasource withFileName:GameListCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
        self.fisrtGotoGameListtable = NO;
    }
    return _loadNewGameListCommand;
}

- (RACCommand*)loadMoreNoticeGameCommad
{
    if (!_loadMoreNoticeGameCommad) {
        _loadMoreNoticeGameCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchNoticeGame:self.code offset:self.noticeGameDatasource.count success:^(id data) {
                    NSMutableArray* array = [NSMutableArray arrayWithArray:self.noticeGameDatasource];
                    [array arrayByAddingObjectsFromArray:(NSArray*)data];
                    self.noticeGameDatasource = nil;
                    self.noticeGameDatasource = array;
                    [DataArchive archiveData:self.noticeGameDatasource withFileName:NoticeGameCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _loadMoreNoticeGameCommad;
}
- (RACCommand*)loadMoreHistoryGameCommand
{
    if (!_loadMoreHistoryGameCommand) {
        _loadMoreHistoryGameCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchHistoryGame:self.code offset:self.historyGameDatasource.count success:^(id data) {
                    NSMutableArray* array = [NSMutableArray arrayWithArray:self.historyGameDatasource];
                    [array appendObjects:data];
                    self.historyGameDatasource = array;
                    [DataArchive archiveData:self.historyGameDatasource withFileName:HistoryGameCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _loadMoreHistoryGameCommand;
}
- (RACCommand*)loadMoreGameListCommand
{
    if (!_loadMoreGameListCommand) {
        _loadMoreGameListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager fetchGameList:self.code offset:self.gameListDatasource.count success:^(id data) {
                    NSMutableArray* array = [NSMutableArray arrayWithArray:self.gameListDatasource];
                    [array appendObjects:data];
                    self.gameListDatasource = array;
                    [DataArchive archiveData:self.gameListDatasource withFileName:GameListCache];
                    [subscriber sendNext:@1];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *aError) {
                    [subscriber sendError:aError];
                }];
                return nil;
            }];
        }];
    }
    return _loadMoreGameListCommand;
}
@end
