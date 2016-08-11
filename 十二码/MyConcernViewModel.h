//
//  MyConcernViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface MyConcernViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<ConcernModel *> *model;
@end
