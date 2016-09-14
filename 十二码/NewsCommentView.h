//
//  NewsCommentView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDABizManager.h"
@class Comments;
@interface NewsCommentView : UIView
@property (nonatomic, strong) NSArray<Comments *> *model;
@property (nonatomic, strong) NSString* targetName;
@property (nonatomic, assign) NSInteger count;
@end
