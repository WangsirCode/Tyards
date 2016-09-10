//
//  SEMTeamHomeModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/5.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamHomeModel.h"

@implementation SEMTeamHomeModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.loadingStatus = 0;
        self.teamId = [(NSNumber*)dictionary[@"ide"] stringValue];
        [self fetchData:[(NSNumber*)dictionary[@"ide"] stringValue]];
        
        NSMutableArray* array = [NSMutableArray new];
        [array addObject:@"全部"];
        for ( NSInteger i = 2016; i > 2000; i --) {
            [array addObject:[@(i) stringValue]];
        }
        self.pickerViewDataSource = [NSArray arrayWithArray:array];
    }
    return self;
}
- (void)fetchData:(NSString*)string
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchTeamInfo:string success:^(id data) {
        self.model = data;
        self.loadingStatus += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchTeamPlayers:string from:0 to:0 success:^(id data) {
        self.players = data;
        self.loadingStatus += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchTeamComments:string success:^(id data) {
        self.comments = data;
        self.loadingStatus += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchTeamGames:string from:0 to:0 success:^(id data) {
        self.games = data;
        self.loadingStatus += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchTeamDetailInfo:string token:[self getToken] from:0 to:0 success:^(id data) {
        self.InfoModel = data;
        self.fan = self.InfoModel.fan;
        self.loadingStatus += 1;
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
                    [manager postdisLikeTeam:[@(self.model.info.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = NO;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                else
                {
                    [manager postLikeTeam:[@(self.model.info.id) stringValue] token:[self getToken] success:^(id data) {
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
- (void)loadSRecord:(NSString*)formDate
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    if ([formDate isEqualToString:@"全部"]) {
        [manager fetchTeamDetailInfo:self.teamId token:[self getToken] from:0 to:0 success:^(id data) {
            self.InfoModel = data;
            self.shouldUpdateRecord = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
    else
    {
        long long from = [self getDate:formDate];
        long long to = [self getDate:[@([formDate integerValue] + 1) stringValue]];
        [manager fetchTeamDetailInfo:self.teamId token:[self getToken] from:from to:to success:^(id data) {
            self.InfoModel = data;
            self.shouldUpdateRecord = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
    
}
- (void)loadList:(NSString*)fromDate
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    if ([fromDate isEqualToString:@"全部"]) {
        [manager fetchTeamPlayers:self.teamId from:0 to:0  success:^(id data) {
            self.players = data;
            self.shouldUpdateList = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
    else
    {
        long long from = [self getDate:fromDate];
        long long to = [self getDate:[@([fromDate integerValue] + 1) stringValue]];
        [manager fetchTeamPlayers:self.teamId from:from to:to success:^(id data) {
            self.players = data;
            self.shouldUpdateList = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
}
- (void)loadSchedule:(NSString*)fromDate
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    if ([fromDate isEqualToString:@"全部"]) {
        [manager fetchTeamGames:self.teamId from:0 to:0 success:^(id data) {
            self.games = data;
            self.shouldUpdateSchedule = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
    else
    {
        long long from = [self getDate:fromDate];
        long long to = [self getDate:[@([fromDate integerValue] + 1) stringValue]];
        [manager fetchTeamGames:self.teamId from:from to:to success:^(id data) {
            self.games = data;
            self.shouldUpdateSchedule = YES;
        } failure:^(NSError *aError) {
            
        }];
    }
}
- (long long)getDate:(NSString*)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comp = [[NSDateComponents alloc] init];
    comp.year = [date integerValue];
    comp.month = 1;
    comp.day = 1;
    comp.minute = 0;
    comp.hour = 0;
    NSDate* date1 = [gregorian dateFromComponents:comp];
    return [date1 timeIntervalSince1970] * 1000;
}
@end
