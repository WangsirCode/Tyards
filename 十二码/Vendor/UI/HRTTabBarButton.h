//
//  HRTTabBarButton.h
//  WOVideo
//
//  Created by Hirat on 16/4/30.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTTabBarButton : UIControl

@property (nonatomic, strong) UIColor* normalColor;
@property (nonatomic, strong) UIColor* selectedColor;

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage;

@end
