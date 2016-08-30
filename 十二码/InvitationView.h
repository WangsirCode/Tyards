//
//  InvitationView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"

@interface InvitationView : UIView
@property (nonatomic,strong) UILabel         * titleLable;
@property (nonatomic,strong) UILabel         * typeLabel;
@property (nonatomic,strong) NSArray<UIView*>* leftArray;
@property (nonatomic,strong) UIButton        * contactBotton;
@property (nonatomic,strong) UIView          * breakLine;
@property (nonatomic,strong) UILabel         * nameLabel;
@property (nonatomic,strong) UILabel         * placeLabel;
@property (nonatomic,strong) UILabel         * dateLabel;
@property (nonatomic,strong) UILabel         * messageLabel;
@property (nonatomic,strong) UIImageView     * leftImageView;
@property (nonatomic,strong) InvitationModel * model;

@end
