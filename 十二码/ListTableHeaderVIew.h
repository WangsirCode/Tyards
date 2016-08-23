//
//  ListTableHeaderVIew.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ListTableHeaderVIewDelegate <NSObject>
@optional
- (void)didClickButtonAtIndex:(NSInteger)index;

@end

@interface ListTableHeaderVIew : UIView
@property (nonatomic,strong) UIButton* scoreButton;
@property (nonatomic,strong) UIButton* scorerButton;
@property (nonatomic,strong) UIButton* awardButton;
@property (nonatomic,strong) id<ListTableHeaderVIewDelegate> delegate;
@end
