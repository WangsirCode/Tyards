//
//  GameinfoViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameinfoViewModel.h"

@implementation GameinfoViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        self.listTableIndex = 0;
        self.teamId = [(NSNumber*)dictionary[@"id"] stringValue];
        [self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
        //先用这个测试
//        [self fetchData:@"9"];
        self.infoTableviewRowNumber = @[@1,@6];
        self.infotableviewCellname = @[@"主办方",@"赛制",@"时间",@"地区",@"球队数量",@"赞助商"];
        
    }
    return self;
}
- (void)fetchData:(NSString*)tournamentId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameInfo:tournamentId token:[self getToken] success:^(id data) {
        self.model = data;
        self.fan = self.model.fan;
        NSMutableArray* array = [[NSMutableArray alloc] init];
        if (self.model.host) {
            [array addObject:self.model.host];
        }
        else
        {
            [array addObject:@""];
        }
        if ([self.model getMatchTypeInfo]) {
            [array addObject:[self.model getMatchTypeInfo]];
        }
        else
        {
            [array appendObject:@""];
        }
        if ([self.model getDateInfo]) {
            [array addObject:[self.model getDateInfo]];
        }
        else
        {
            [array addObject:@""];
        }
        if (self.model.area.name) {
            [array addObject:self.model.area.name];
        }
        else
        {
            [array addObject:@""];
        }
        [array addObject:[@(self.model.teamSize) stringValue]];
        if (self.model.sponsor) {
            [array addObject:self.model.sponsor];
        }
        else
        {
            [array addObject:@""];
        }
        
        self.infoTableViewCellInfo = array;
        
        self.status += 1;
    } failure:^(NSError *aError) {

    }];
    [manager fetchGameSchedule:tournamentId offset:0 success:^(id data) {
        self.scheduleModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchGameTeams:tournamentId success:^(id data) {
        self.teamModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchAwardList:tournamentId success:^(id data) {
        self.awardModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchScorerList:tournamentId success:^(id data) {
        self.scorerModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchScoreList:tournamentId success:^(id data) {
        self.scoreModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchPolicy:tournamentId success:^(id data) {
        self.policyModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                if (self.fan) {
                    [manager postdisLikeTournament:[@(self.model.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = NO;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                else
                {
                    [manager postLikeTournament:[@(self.model.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = YES;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                
                return nil;
            }];
        }];
    }
    return _likeCommand;
}
- (RACCommand *)shareCommand
{
    if (!_shareCommand) {
        _shareCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"点击了分享按钮");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _shareCommand;
}
- (void)loadMoreSchedule
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameSchedule:self.teamId offset:[self getOffset] success:^(id data) {
        NSMutableArray* array = [NSMutableArray arrayWithArray:self.scheduleModel];
        [array appendObjects:(NSArray*)data];
        self.scheduleModel = array;
        self.shouldReloadScheduleTable = YES;
    } failure:^(NSError *aError) {
        
    }];
}
- (NSInteger)getOffset
{
    __block NSInteger offset= 0;
    [self.scheduleModel enumerateObjectsUsingBlock:^(TournamentGamesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        offset += obj.games.count;
    }];
    return offset;
}
@end
