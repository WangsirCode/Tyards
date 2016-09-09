//
//  MakeInvitationViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface MakeInvitationViewModel : SEMViewModel
@property (nonatomic,strong) RACCommand* postCommand;
@property (nonatomic,strong) NSArray* titleArray;
@property (nonatomic,strong) InvitationModel* model;
@property (nonatomic,assign) BOOL valid;
@end
