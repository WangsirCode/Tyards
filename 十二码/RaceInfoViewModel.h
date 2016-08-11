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
@property (nonatomic, strong) NSArray<News *> * newsModel;
@property (nonatomic, strong) Games *gameModel;
@property (nonatomic,strong) NSArray<Comments*>* messageModel;
@property (nonatomic,assign ) NSInteger     status;
@property (nonatomic,strong ) RACCommand    * shareCommand;
@property (nonatomic,strong ) RACCommand    * likeCommand;
@end
