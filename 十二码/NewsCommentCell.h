//
//  NewsCommentCell.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/12.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
#import "ImageContainerView.h"
#import "NewsCommentView.h"
@class NewsDetailModel,ImageContainerView,NewsCommentView;
@interface NewsCommentCell : UITableViewCell
@property (nonatomic, strong) NewsDetailModel    *model;
@property (nonatomic,strong ) ImageContainerView * imageContainer;
@property (nonatomic,strong ) UILabel            * timeLabel;
@property (nonatomic,strong ) NewsCommentView    * commentView;
@end
