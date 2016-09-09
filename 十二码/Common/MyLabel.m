//
//  MyLabel.m
//  test
//
//  Created by 汪宇豪 on 16/9/4.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
