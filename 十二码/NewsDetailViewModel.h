//
//  NewsDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "NewsDetailResponseModel.h"
@interface NewsDetailViewModel : SEMViewModel
@property (nonatomic, strong) NewsDetailModel *newdetail;
@property (nonatomic,assign) NSInteger identifier;
@property (nonatomic,assign) BOOL isLoaded;
@property (nonatomic,assign)BOOL getHeight;
@property (nonatomic,assign)BOOL heightSet;
@property (nonatomic,strong)RACCommand* shareCommand;
@property (nonatomic,strong)RACCommand* likeCommand;
@property (nonatomic,assign)BOOL webViewLoaded;
@property (nonatomic,assign)BOOL isHotTopic;
@property (nonatomic,assign) BOOL   shouldReloadCommentTable;
@property (nonatomic,assign) BOOL isTableView;
@property (nonatomic,strong) NSString * detailId;
@property (nonatomic,assign) NSInteger newsId;
@property (nonatomic,assign) NSInteger targetCommentId;
@property (nonatomic,assign) NSInteger remindId;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,assign) NSInteger postType;
@property (nonatomic,assign) NSInteger num;
- (void)addNews;
@end
