//
//  CommentCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
#import "NewsDetailResponseModel.h"
@interface CommentCell : UITableViewCell
@property (nonatomic,strong)Comments* model;
@property (nonatomic,strong)CommentView* commentView;
@property (nonatomic,strong) UILabel* timeLabel;
@end
