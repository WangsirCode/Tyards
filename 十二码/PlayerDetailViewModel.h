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
@property (nonatomic, strong) PlayerModel *model;
@property (nonatomic,strong) NSArray<Comments*>* comments;
@property (nonatomic,strong ) RACCommand      * shareCommand;
@property (nonatomic,strong ) RACCommand      * likeCommand;
@end
