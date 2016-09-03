//
//  SEMNewsVIewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "SEMNetworkingManager.h"
#import "MDABizManager.h"
@interface SEMNewsVIewModel : SEMViewModel
@property (nonatomic,strong ) NSString   * title;
@property (nonatomic,strong ) NSArray<News            *> *newsDataSource;
@property (nonatomic,strong ) NSArray<News            *> *attensionDatasource;
@property (nonatomic, strong) NSArray<Topic1     *> * topicDataSource;
@property (nonatomic,strong ) RACCommand * loadNewNewsCommand;
@property (nonatomic,strong ) RACCommand * loadMoreNewsCommad;
@property (nonatomic,strong ) RACCommand * loadNewTopicsCommand;
@property (nonatomic,strong ) RACCommand * loadMoreTopicsCommand;
@property (nonatomic,strong) RACCommand  * loadNewFansCommand;
@property (nonatomic,strong) RACCommand  * loadMoreFansCommand;
@property (nonatomic,strong ) NSString   * code;
@property (nonatomic,assign ) NSInteger  selectedItem;
@property (nonatomic,assign) BOOL isLogined;
@property (nonatomic,assign)BOOL fisrtGotoTopic;
@property (nonatomic,assign)BOOL fisrtGotoAttension;
@end
