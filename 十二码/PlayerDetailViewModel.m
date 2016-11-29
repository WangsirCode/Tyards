//
//  PlayerDetailViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PlayerDetailViewModel.h"

@implementation PlayerDetailViewModel
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.status = 0;
        [self fetchData:[(NSNumber*)dictionary[@"id"] stringValue]];
        self.playerId = [(NSNumber*)dictionary[@"id"] stringValue];
        self.postType = 1;
    }
    return self;
}
- (void)fetchData:(NSString*)playerId
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchPlayerInfo:playerId offset:0 success:^(id data) {
        self.model = data;
        self.status += 1;
    } failure:^(NSError *aError) {
    }];
    [manager fetchPlayerData:playerId token:[self getToken] success:^(id data) {
        self.palyerData = data;
        self.status += 1;
        self.fan = self.palyerData.fan;
    } failure:^(NSError *aError) {
        
    }];
    [manager fetchPlayerNews:playerId offset:0 success:^(id data) {
        self.messageModel = data;
        self.status +=1;
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
                    [manager postdisLikePlayer:[@(self.model.player.id) stringValue] token:[self getToken] success:^(id data) {
                        self.didFaned = YES;
                        self.fan = NO;
                        [subscriber sendNext:@1];
                        [subscriber sendCompleted];
                    } failure:^(NSError *aError) {
                        
                    }];
                }
                else
                {
                    [manager postLikePlayer:[@(self.model.player.id) stringValue] token:[self getToken] success:^(id data) {
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
                        [manager postPlayerNews:self.playerId content:self.content images:string token:[self getToken] success:^(id data) {
                            [manager fetchPlayerNews:self.playerId offset:0 success:^(id data) {
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
            [manager postPlayerNews:self.playerId content:self.content images:@"" token:[self getToken] success:^(id data) {
                [manager fetchPlayerNews:self.playerId offset:0 success:^(id data) {
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
            [manager fetchPlayerNews:self.playerId offset:0 success:^(id data) {
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
            [manager fetchPlayerNews:self.playerId offset:0 success:^(id data) {
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
    [manager fetchPlayerInfo:self.playerId offset:self.model.articles.count success:^(id data) {
        NSMutableArray* array = [NSMutableArray arrayWithArray:self.model.articles];
        [array appendObjects:((CoachModel*)data).articles];
        self.model = data;
        self.model.articles = array;
        self.updateNewsTable = YES;
    } failure:^(NSError *aError) {
    }];
}
- (void)loadMoreComment
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchPlayerNews:self.playerId offset:self.messageModel.count success:^(id data) {
        NSMutableArray* array = [NSMutableArray arrayWithArray:self.messageModel];
        [array appendObjects:((PlayerModel*)data).newes];
        self.messageModel = array;
        self.updateCommentTable = YES;
    } failure:^(NSError *aError) {
    }];
}
@end
