//
//  MakeInvitationController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@protocol MakeInvitationControllerDelegate
- (void)didMakeInvitation:(InvitationModel*)model;
@end
@interface MakeInvitationController : UIViewController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@property (nonatomic,strong) id<MakeInvitationControllerDelegate> delegate;
@end
