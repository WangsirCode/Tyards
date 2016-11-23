//
//  ColleageSearchController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeUserInfoResponseModel.h"

@protocol SearchCollegeDalegate <NSObject>
- (void)didSelectedItem:(College*)uni;
@end

@interface ColleageSearchController : UIViewController
@property (nonatomic,strong)id<SearchCollegeDalegate> delegate;
@end
