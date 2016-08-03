//
//  CommentView.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailResponseModel.h"
/*!
 *  @author 汪宇豪, 16-08-01 20:08:46
 *
 *  @brief 显示评论的view
 */
@interface CommentView : UIView
@property (nonatomic,strong)NSArray<Reply*>* replys;
@property (nonatomic,strong)NSMutableArray<UILabel*>* labels;
- (instancetype)initWithReplies:(NSArray*)replies;
@end
