//
//  NewsCommentView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailResponseModel.h"
@protocol NewsCommentViewDelegate
- (void)didClickButton:(NSInteger)commentId remindId:(NSInteger)remindId name:(NSString*)name;
@end
@class Comments;
@interface NewsCommentView : UIView
@property (nonatomic, strong) NSArray<Comments *> *model;
@property (nonatomic, strong) NSString* targetName;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic,strong) id<NewsCommentViewDelegate> delegate;
@end
