//
//  UIImage+IconFont.m
//  Fotoz
//
//  Created by Hirat on 16/2/21.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "UIImage+IconFont.h"
#import "UIView+Hirat.h"
#import "UIFont+IconFont.h"

@implementation UIImage (IconFont)

+ (UIImage*)iconWithType:(IconType)type fontSize:(CGFloat)fontSize
{
    return [UIImage iconWithType: type fontSize: fontSize color: [UIColor blackColor]];
}

+ (UIImage*)iconWithType:(IconType)type fontSize:(CGFloat)fontSize color:(UIColor*)color
{
    UILabel* contentLabel = [UILabel new];
    contentLabel.textColor = color;
    contentLabel.text = [NSString stringWithFormat: @"%C", type];
    contentLabel.font = [UIFont iconFontWithName: @"iconfont" size: fontSize];
    [contentLabel sizeToFit];
    
    return contentLabel.viewToImage;
}

@end
