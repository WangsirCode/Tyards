//
//  ShareView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-08-03 10:08:43
 *
 *  @brief 第三方分享的view
 */
@protocol ShareViewDelegate <NSObject>

- (void)didSelectedShareView:(NSInteger)index;

@end
@interface ShareView : UIView
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton* wxFriendButton;
@property (nonatomic,strong) UIButton* wxMomentButton;
@property (nonatomic,strong) UIButton* qqFriendButton;
@property (nonatomic,strong) UIButton* qZoneButton;
@property (nonatomic,strong) UIButton* bottomButton;
@property (nonatomic,strong) UILabel* wxFriendLabel;
@property (nonatomic,strong) UILabel* wxMomentLabel;
@property (nonatomic,strong) UILabel* qqFriendLabel;
@property (nonatomic,strong) UILabel* qZoneLabel;

@property (nonatomic,retain)id<ShareViewDelegate> delegate;
@end
