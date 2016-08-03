//
//  MeTopView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MeTopView.h"
#import "MDABizManager.h"
@implementation MeTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.backImageView];
    [self addSubview:self.infoView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.userHeadBackView];
    [self addSubview:self.userHeadView];

}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self);
    }];
    
    [self.userHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(3.1);
        make.width.equalTo(self.mas_height).dividedBy(3.1);
    }];
    [self.userHeadBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self.mas_height).dividedBy(2.85);
        make.width.equalTo(self.mas_height).dividedBy(2.85);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.userHeadView.mas_bottom).offset(25*scale);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(self.mas_height).dividedBy(20);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10*scale);
        make.width.equalTo(self.mas_width).dividedBy(6);
    }];
    
}
- (void)bindModel
{
    RAC(self.userHeadView,image) = RACObserve(self, headImage);
    RAC(self.nameLabel,text) = RACObserve(self, name);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _userHeadView.layer.cornerRadius = _userHeadView.width / 2;
    _userHeadBackView.layer.cornerRadius = _userHeadBackView.width / 2;
}


#pragma mark-Getter
- (UIImageView*)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"深色背景"];
    }
    return _backImageView;
}
- (MeinfoVIew*)infoView
{
    if (!_infoView) {
        _infoView = [[MeinfoVIew alloc] initWithFrame:CGRectZero];
    }
    return _infoView;
}
- (UIImageView*)userHeadView
{
    if (!_userHeadView) {
        _userHeadView = [[UIImageView alloc] init];
        _userHeadView.layer.masksToBounds = YES;
        _userHeadView.userInteractionEnabled = YES;
    }
    return _userHeadView;
}
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UIImageView*)userHeadBackView
{
    if (!_userHeadBackView) {
        _userHeadBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"绿白圈圈icon"]];
        _userHeadBackView.layer.masksToBounds = YES;
    }
    return _userHeadBackView;
}
@end
