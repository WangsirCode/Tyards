//
//  PlayerDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface PlayerDetailViewModel : SEMViewModel
@property (nonatomic, strong) PlayerModel     *model;
@property (nonatomic, strong) NSArray<NewsDetailModel *> *messageModel;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@property (nonatomic, strong) PlayerDataModel *palyerData;
@property (nonatomic,strong) NSArray<UIImage*>* images;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) BOOL fan;
@property (nonatomic,assign) BOOL didFaned;
@property (nonatomic,assign) BOOL   shouldReloadCommentTable;
@property (nonatomic,strong) NSString * playerId;
@property (nonatomic,assign) NSInteger newsId;
@property (nonatomic,assign) NSInteger targetCommentId;
@property (nonatomic,assign) NSInteger remindId;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,assign) NSInteger postType;
@property (nonatomic,assign) NSInteger num;
- (void)addNews;
@end
