//
//  UIView+Hirat.h
//  WOVideo
//
//  Created by Hirat on 16/5/1.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Hirat)

/// 将视图转换为UIImage
@property (nonatomic, strong, readonly) UIImage* viewToImage;

+ (void)makeEqualWidthViews:(NSArray*)views inView:(UIView*)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding;

@end
