//
//  MeLoginView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MeLoginView.h"
#import "MDABizManager.h"
@implementation MeLoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self addSubViews];
        [self makeConstraits];
    }
    return self;
}
- (void)addSubViews
{
    [self addSubview:self.title];
    [self addSubview:self.button];
}

- (void)makeConstraits
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(1.3);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(5);
        make.left.and.right.and.bottom.equalTo(self);
    }];
}
- (UILabel*)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13 ];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
    }
    return _title;
}
- (UIButton*)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];

    }
    return _button;
}

@end
