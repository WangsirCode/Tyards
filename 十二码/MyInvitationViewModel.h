//
//  MyInvitationViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface MyInvitationViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<InvitationModel *> *myInvitaions;
@property (nonatomic, strong) NSArray<InvitationModel *> *myClosedInvitations;
@property (nonatomic,assign) NSInteger status;
@end
