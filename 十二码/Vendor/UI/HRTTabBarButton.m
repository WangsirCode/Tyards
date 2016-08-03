//
//  HRTTabBarButton.m
//  WOVideo
//
//  Created by Hirat on 16/4/30.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "HRTTabBarButton.h"
#import <Masonry.h>
#import <YYCategories.h>

@interface HRTTabBarButton ()
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIImage* selectedImage;
@property (nonatomic, copy) NSString* title;

@property (assign, getter = isTrackingInside) BOOL trackingInside;
@end

@implementation HRTTabBarButton

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage
{
    if (self = [super initWithFrame: CGRectZero])
    {
        self.image = image;
        self.selectedImage = selectedImage;
        self.title = title;
        
        self.normalColor = [UIColor colorWithHexString: @"595959"];
        self.selectedColor = [UIColor colorWithHexString: @"fd484c"];
        
        [self setup];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected: selected];
    
    if (selected)
    {
        self.imageView.image = self.selectedImage;
        self.titleLabel.textColor = self.selectedColor;
    }
    else
    {
        self.imageView.image = self.image;
        self.titleLabel.textColor = self.normalColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted: highlighted];
}

- (void)setup
{
    UIView* containView = [UIView new];
    containView.userInteractionEnabled = YES;
    [self addSubview: containView];
    
    self.imageView = [[UIImageView alloc] initWithImage: self.image];
    self.imageView.userInteractionEnabled = YES;
    [containView addSubview: self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.and.bottom.mas_equalTo(0);
        make.size.mas_equalTo(self.image.size);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize: 14];
    self.titleLabel.text = self.title;
    self.titleLabel.userInteractionEnabled = YES;
    [containView addSubview: self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView.mas_trailing).offset(5);
        make.centerY.equalTo(self);
        make.trailing.mas_equalTo(0);
    }];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
 
}

#pragma mark - Touchs
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *touchView = [super hitTest:point withEvent:event];
    if ([self pointInside:point withEvent:event])
    {
        return self;
    }
    
    return touchView;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.trackingInside = YES;
    self.selected = !self.selected;
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL wasTrackingInside = self.trackingInside;
    self.trackingInside = [self isTouchInside];
    
    if (wasTrackingInside && !self.isTrackingInside)
    {
        self.selected = !self.selected;
    }
    else if (!wasTrackingInside && self.isTrackingInside)
    {
        self.selected = !self.selected;
    }
    
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.trackingInside = [self isTouchInside];
    if (self.isTrackingInside)
    {
        self.selected = !self.selected;
    }
    
    self.trackingInside = NO;
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    self.trackingInside = [self isTouchInside];
    if (self.isTrackingInside)
    {
        self.selected = !self.selected;
    }
    
    self.trackingInside = NO;
    [super cancelTrackingWithEvent:event];
}
@end
