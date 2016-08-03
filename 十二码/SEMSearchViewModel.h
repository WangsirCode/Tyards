//
//  SEMSearchViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "MDABizManager.h"
#import "SEMViewModel.h"
#import "SearchModel.h"
#import "SearchResultsModel.h"
@interface SEMSearchViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<Area              *> *datasource;
@property (nonatomic, strong) NSArray<Universities *> *universities;
@property (nonatomic,assign) BOOL isSearching;
@property (nonatomic,assign) BOOL needReloadTableview;
@property (nonatomic,strong) RACCommand* searchCommand;
@end
