//
//  UIFont+IconFont.m
//  Fotoz
//
//  Created by Hirat on 16/2/21.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "UIFont+IconFont.h"
#import <CoreText/CoreText.h>

@implementation UIFont (IconFont)

#pragma mark - 自定义字体

+ (UIFont *)iconFontWithName:(NSString *)fileName size:(CGFloat)fontSize;
{
    NSString *fontPath = [[NSBundle mainBundle] pathForResource: fileName ofType:@"ttf"];
    
    NSURL *fontUrl = [NSURL fileURLWithPath: fontPath];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CFErrorRef error;
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, &error);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size: fontSize];
    CGFontRelease(fontRef);
    
    return font;
}

@end
