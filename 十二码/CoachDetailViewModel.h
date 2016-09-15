//
//  CoachDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface CoachDetailViewModel : SEMViewModel
@property (nonatomic, strong) CoachModel     *model;
@property (nonatomic, strong) NSArray<NewsDetailModel *> *newsModel;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@property (nonatomic, strong) CoachDataModel *palyerData;
@property (nonatomic,strong) NSArray<UIImage*>* images;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) BOOL fan;
@property (nonatomic,assign) BOOL didFaned;
@property (nonatomic,strong) NSString * coachId;
@property (nonatomic,assign) NSInteger newsId;
@property (nonatomic,assign) NSInteger targetCommentId;
@property (nonatomic,assign) NSInteger remindId;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,assign) NSInteger postType;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,assign) BOOL   shouldReloadCommentTable;
- (void)addNews;
@end
