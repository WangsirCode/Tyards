//
//  MeColleageSearchViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MeUserInfoResponseModel.h"
@interface MeColleageSearchViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<College *>* dataSource;
@property (nonatomic, strong) NSArray<College *> *universities;
@property (nonatomic,assign) BOOL isSearching;
@property (nonatomic,assign) BOOL needReloadTableview;
@property (nonatomic,strong) RACCommand* searchCommand;
@end
