//
//  UIImage+IconFont.h
//  Fotoz
//
//  Created by Hirat on 16/2/21.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef unichar IconType;

typedef NS_ENUM(IconType, IconTypeCommonIconsType)
{
    IconTypeCommonIconEdit          = 0xe601,
    IconTypeCommonIconMenu          = 0xe602,
    IconTypeCommonIconBack          = 0xe640,
    IconTypeCommonIconLoading       = 0xe61f,
    IconTypeCommonIconAlbum         = 0xe616,
    IconTypeCommonIconSuccess       = 0xe61e,
    IconTypeCommonIconError         = 0xe625,
    IconTypeCommonIconClose         = 0xe621,
    IconTypeCommonIconNote          = 0xe61a,
    IconTypeCommonIconSearch        = 0xe610,
    IconTypeCommonIconUser          = 0xe613,
    IconTypeCommonIconNoteFull      = 0xe639,
    IconTypeCommonIconSearchFull    = 0xe631,
    IconTypeCommonIconUserFull      = 0xe636,
    IconTypeCommonIconDownArrow     = 0xe63d,
    IconTypeCommonIconGroup         = 0xe60a,
    IconTypeCommonIconDelete        = 0xe60b,
};

@interface UIImage (IconFont)

/**
 *  获取 icon.ttf 中的 icon 并转换为 UIImage
 *
 *  @param type     icon 的 unicode
 *  @param fontSize 大小
 *
 *  @return UIImage
 */
+ (UIImage*)iconWithType:(IconType)type fontSize:(CGFloat)fontSize;

/**
 *  获取 icon.ttf 中的 icon 并转换为 UIImage
 *
 *  @param type     icon 的 unicode
 *  @param fontSize 大小
 *  @param color    颜色
 *
 *  @return UIImage
 */
+ (UIImage*)iconWithType:(IconType)type fontSize:(CGFloat)fontSize color:(UIColor*)color;


@end
