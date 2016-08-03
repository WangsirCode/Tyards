//
//  UIFont+IconFont.h
//  Fotoz
//
//  Created by Hirat on 16/2/21.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (IconFont)

/**
 *  自定义 iconFont
 *
 *  @param fileName 字体名称
 *  @param size     字体大小
 *
 *  @return 字体
 */
+ (UIFont *)iconFontWithName:(NSString *)fileName size:(CGFloat)fontSize;

@end
