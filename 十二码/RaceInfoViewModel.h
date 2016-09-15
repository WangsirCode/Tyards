//
//  RaceInfoViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface RaceInfoViewModel : SEMViewModel
@property (nonatomic, strong) RaceDataModel *dataModel;
@property (nonatomic, strong) NSArray<NewsDetailModel *> *messageModel;
@property (nonatomic, strong) MetchEventModel *eventModel;
@property (nonatomic, strong) NSArray<News *> * newsModel;
@property (nonatomic, strong) Games *gameModel;
@property (nonatomic,strong) NSArray<UIImage*>* images;
@property (nonatomic,assign ) NSInteger     status;
@property (nonatomic,strong ) RACCommand    * shareCommand;
@property (nonatomic,strong ) RACCommand    * likeCommand;
@property (nonatomic,strong) NSString * raceId;
@property (nonatomic,assign) NSInteger newsId;
@property (nonatomic,assign) NSInteger targetCommentId;
@property (nonatomic,assign) NSInteger remindId;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,assign) NSInteger postType;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,assign) BOOL   shouldReloadCommentTable;
- (void)addNews;
@end
