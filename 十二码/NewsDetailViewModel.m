//
//  NewsDetailViewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsDetailViewModel.h"

@implementation NewsDetailViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.identifier = [dictionary[@"ides"] integerValue];
        self.detailId = [@(self.identifier) stringValue];
        self.isTableView = YES;
        NSString* string = dictionary[@"hot"];
        if (string) {
            [self fetchHotData];
            self.isHotTopic = YES;
        }
        else
        {
            [self fetchdata];
            self.isHotTopic = NO;
        }
        self.postType = 1;

    }
    return self;
}
- (void)fetchdata
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchNewsDetail:self.identifier success:^(id data) {
        self.newdetail = data;
        self.isLoaded = YES;
    } failure:^(NSError *aError) {
        
    }];
}
- (void)fetchHotData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchHotDetail:[@(self.identifier) stringValue]  success:^(id data) {
        self.newdetail = data;
        self.isLoaded = YES;
    } failure:^(NSError *aError) {
        
    }];
}
-(RACCommand *)likeCommand
{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"点击了收藏按钮");
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
    //添加新的评论
    if (self.postType == 1) {
        if (self.isHotTopic) {
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager commentHottopic:self.identifier content:self.content targetCommentId:0 remind:0 token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
        else
        {
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager postComment:self.identifier content:self.content targetCommentId:0 remind:0 token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
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
        if (self.isHotTopic) {
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager commentHottopic:self.identifier content:self.content targetCommentId:self.targetCommentId remind:0 token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
        else{
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager postComment:self.identifier content:self.content targetCommentId:self.targetCommentId remind:0 token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
        
    }
    //回复某条评论
    else if (self.postType == 3)
    {
        if (self.isHotTopic) {
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager commentHottopic:self.identifier content:self.content targetCommentId:self.targetCommentId remind:self.remindId token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
        else{
            SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
            [manager postComment:self.identifier content:self.content targetCommentId:self.targetCommentId remind:self.remindId token:[self getToken] success:^(id data) {
                [manager fetchNewsDetail:self.identifier success:^(id data) {
                    self.newdetail = data;
                    self.shouldReloadCommentTable = YES;
                } failure:^(NSError *aError) {
                    
                }];
            } failure:^(NSError *aError) {
                
            }];
        }
    }
}
@end
