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
@end
