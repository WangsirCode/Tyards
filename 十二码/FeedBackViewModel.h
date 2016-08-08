//
//  FeedBackViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface FeedBackViewModel : SEMViewModel
@property (nonatomic,strong)RACCommand* submitCommand;
@property (nonatomic,strong)NSString* feedBack;
@end
