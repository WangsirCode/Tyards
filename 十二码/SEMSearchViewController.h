//
//  SEMSearchViewController.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
/*!
 *  @author 汪宇豪, 16-07-24 19:07:09
 *
 *  @brief 搜索界面
 */
@protocol SEMSearchViewControllerDelegate <NSObject>
- (void)didSelectedItem:(NSString*)name diplayname:(NSString*)dispalyname uni:(Universities*)uni;
@end

@interface SEMSearchViewController : UIViewController
@property (nonatomic,strong)id<SEMSearchViewControllerDelegate> delegate;
@end
