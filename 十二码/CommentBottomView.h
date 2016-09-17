//
//  CommentBottomView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentBottomView : UIView
@property (nonatomic,strong) UITextField* textField;
@property (nonatomic,strong) UIButton* imageButton;
@property (nonatomic,strong) UIButton* sendButton;
- (void)reSetView;
@end
