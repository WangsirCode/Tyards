//
//  HomeHeadView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HomeHeadView.h"
#import "YYCategories.h"
#import "Masonry.h"
#import "MDABizManager.h"
@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self makeConstraits];
    }
    return self;
}

- (void)addSubviews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.scrollView];
    [self addSubview:self.grayView];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(1.21);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(26*scale);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(10*scale);
        make.right.and.bottom.equalTo(self);
    }];
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor BackGroundColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(-1);
        make.left.and.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
}

#pragma mark -Getter
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"热门推荐";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
        _titleLabel.font = [UIFont systemFontOfSize:15*self.scale];
    }
    return _titleLabel;
}

- (SDCycleScrollView*)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _scrollView.currentPageDotColor = [UIColor whiteColor];
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _scrollView;
}

- (UIView*)grayView
{
    if(!_grayView)
    {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    }
    return _grayView;
}
@end
