//
//  RaceInfoViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "RaceInfoViewModel.h"

@implementation RaceInfoViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        self.postType = 1;
        [self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
        self.raceId = [(NSNumber*)dictionary[@"id"] stringValue];
    }
    return self;
}
- (void)fetchData:(NSString*)matchId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameNews:matchId offset:0 success:^(id data) {
        self.newsModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchGameDetail:matchId success:^(id data) {
        self.gameModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchGameMessage:matchId offset:0 success:^(id data) {
        self.messageModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchRaceData:matchId success:^(id data) {
        self.dataModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchRaceEvents:matchId success:^(id data) {
        self.eventModel = data;
        self.status += 1;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
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
- (void)addNews
{
    //添加球队新闻
    if (self.postType == 1) {
        NSInteger count = self.images.count;
        if (self.content == nil) {
            self.content = @"发表图片说说";
        }
        if(count > 0)
        {
            self.num = 0;
            NSMutableArray<NSNumber*>* array = [NSMutableArray new];
            [self.images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData *_data = UIImageJPEGRepresentation(obj, 0.5f);
                NSString *_encodedImageStr = [_data base64EncodedString];
                NSMutableString* string = [NSMutableString stringWithString:@"data:image/png;base64,"];
                [string appendString:_encodedImageStr];
                SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
                [manager postImage:string success:^(id data) {
                    NSInteger idne = [(NSNumber*)data integerValue];
                    [array appendObject:@(idne)];
                    self.num ++;
                    if (self.num == count) {
                        NSMutableString* string = [NSMutableString new];
                        [array enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [string appendString:[obj stringValue]];
                            if (idx != count - 1) {
                                [string appendString:@","];
                            }
                        }];

                        [manager postMatchNews:self.raceId content:self.content images:string token:[self getToken] success:^(id data) {
                            [manager fetchGameMessage:self.raceId offset:0 success:^(id data) {
                                self.messageModel = data;
                                self.shouldReloadCommentTable = YES;
                            } failure:^(NSError *aError) {
                                
                            }];
                        } failure:^(NSError *aError) {
                            
                        }];
                    }
                } failure:^(NSError *aError) {
                    
                }];
            }];
        }
        else
        {
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager postMatchNews:self.raceId content:self.content images:@"" token:[self getToken] success:^(id data) {
                [manager fetchGameMessage:self.raceId offset:0 success:^(id data) {
                    self.messageModel = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
        
    }
    //回复楼主
    else if (self.postType == 2)
    {
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager postComment:self.newsId content:self.content targetCommentId:0 remind:0 token:[self getToken] success:^(id data) {
            [manager fetchGameMessage:self.raceId offset:0 success:^(id data) {
                self.messageModel = data;
                self.shouldReloadCommentTable = YES;
            } failure:^(NSError *aError) {
                
            }];
        } failure:^(NSError *aError) {
            
        }];
    }
    else if (self.postType == 3)
    {
        SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
        [manager postComment:self.newsId content:self.content targetCommentId:self.targetCommentId remind:self.remindId token:[self getToken] success:^(id data) {
            [manager fetchGameMessage:self.raceId offset:0 success:^(id data) {
                self.messageModel = data;
                self.shouldReloadCommentTable = YES;
            } failure:^(NSError *aError) {
                
            }];
        } failure:^(NSError *aError) {
            
        }];
    }
}
- (void)loadMoreNews
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameNews:self.raceId offset:self.newsModel.count success:^(id data) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.newsModel];
        [array appendObjects:(NSArray*)data];
        self.newsModel = array;
        self.updateNewsTable = YES;
    } failure:^(NSError *aError) {
        
    }];
}
- (void)loadMoreMessages
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchGameMessage:self.raceId offset:self.messageModel.count success:^(id data) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.messageModel];
        [array appendObjects:(NSArray*)data];
        self.messageModel = array;
        self.updateMessagaTable = YES;
    } failure:^(NSError *aError) {
        
    }];
}
@end
