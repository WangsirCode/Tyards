//
//  ShareView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ShareView.h"
#import "MDABizManager.h"
@implementation ShareView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sd_addSubviews:@[self.titleLabel,self.qZoneLabel,self.qqFriendLabel,self.qqFriendButton,self.qZoneButton,self.wxMomentLabel,self.wxMomentButton,self.wxFriendLabel,self.wxFriendButton,self.bottomButton]];
        self.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    [[self.wxFriendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.delegate didSelectedShareView:0];
    }];
    [[self.wxMomentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.delegate didSelectedShareView:1];
    }];
    [[self.qqFriendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.delegate didSelectedShareView:2];
    }];
    [[self.qZoneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.delegate didSelectedShareView:3];
    }];
    [[self.bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.delegate didSelectedShareView:4];
    }];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.titleLabel.sd_layout
//    .topSpaceToView(self,10)
//    .leftEqualToView(self)
//    .rightEqualToView(self)
//    .autoHeightRatio(0);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.and.right.equalTo(self);
    }];
//    self.wxFriendButton.sd_layout
//    .topSpaceToView(self.titleLabel,10)
//    .heightIs(60*self.scale)
//    .widthEqualToHeight()
//    .leftSpaceToView(self,15*self.scale);
    [self.wxFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(15*self.scale);
        make.height.equalTo(@(60*self.scale));
        make.width.equalTo(@(60*self.scale));
    }];
    [self.wxFriendButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.wxMomentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.wxFriendButton.mas_right).offset(30*self.scale);
        make.height.equalTo(@(60*self.scale));
        make.width.equalTo(@(60*self.scale));
    }];
    [self.wxMomentButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.qqFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.wxMomentButton.mas_right).offset(30*self.scale);
        make.height.equalTo(@(60*self.scale));
        make.width.equalTo(@(60*self.scale));
    }];
    [self.qqFriendButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.qZoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.qqFriendButton.mas_right).offset(30*self.scale);
        make.height.equalTo(@(60*self.scale));
        make.width.equalTo(@(60*self.scale));
    }];
    [self.qZoneButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
//    
//    self.wxMomentButton.sd_layout
//    .topSpaceToView(self.titleLabel,10)
//    .heightIs(60*self.scale)
//    .widthEqualToHeight()
//    .leftSpaceToView(self.wxFriendButton,30*self.scale);
//    
//    self.qqFriendButton.sd_layout
//    .topSpaceToView(self.titleLabel,10)
//    .leftSpaceToView(self.wxMomentButton,30*self.scale)
//    .heightIs(60*self.scale)
//    .widthEqualToHeight();
//    
//    self.qZoneButton.sd_layout
//    .topSpaceToView(self.titleLabel,10)
//    .leftSpaceToView(self.qqFriendButton,30*self.scale)
//    .heightIs(60*self.scale)
//    .widthEqualToHeight();
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(@(49*self.scale));
    }];
    
    
//    self.wxFriendLabel.sd_layout
//    .centerXIs(self.wxFriendButton.centerX)
//    .topSpaceToView(self.wxFriendButton,8)
//    .autoHeightRatio(0);
    [self.wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxFriendButton.mas_bottom).offset(8);
        make.centerX.equalTo(self.wxFriendButton.mas_centerX);
    }];
    [self.wxMomentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxMomentButton.mas_bottom).offset(8);
        make.centerX.equalTo(self.wxMomentButton.mas_centerX);
    }];
    [self.qqFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qqFriendButton.mas_bottom).offset(8);
        make.centerX.equalTo(self.qqFriendButton.mas_centerX);
    }];
    [self.qZoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qZoneButton.mas_bottom).offset(8);
        make.centerX.equalTo(self.qZoneButton.mas_centerX);
    }];
//    self.wxMomentLabel.sd_layout
//    .centerXIs(self.wxMomentButton.centerX)
//    .topSpaceToView(self.wxMomentButton,8)
//    .autoHeightRatio(0);
//    
//    self.qqFriendLabel.sd_layout
//    .centerXIs(self.qqFriendButton.centerX)
//    .topSpaceToView(self.qqFriendButton,8)
//    .autoHeightRatio(0);
//    
//    self.qZoneLabel.sd_layout
//    .centerXIs(self.qZoneButton.centerX)
//    .topSpaceToView(self.qZoneButton,8)
//    .autoHeightRatio(0);
    
}


#pragma mark -getter
- (UIButton *)wxFriendButton
{
    if (!_wxFriendButton) {
        _wxFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxFriendButton setImage:[UIImage imageNamed:@"wechat_s"] forState:UIControlStateNormal];
        _wxFriendButton.backgroundColor = [UIColor whiteColor];
        _wxFriendButton.layer.cornerRadius = 13;

    }
    return _wxFriendButton;
}

-(UIButton *)wxMomentButton
{
    if (!_wxMomentButton) {
        _wxMomentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxMomentButton setImage:[UIImage imageNamed:@"wechat moment-s"] forState:UIControlStateNormal];
        _wxMomentButton.backgroundColor = [UIColor whiteColor];
        _wxMomentButton.layer.cornerRadius = 13;
    }
    return _wxMomentButton;
}

-(UIButton *)qqFriendButton
{
    if (!_qqFriendButton) {
        _qqFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqFriendButton setImage:[UIImage imageNamed:@"qq_s"] forState:UIControlStateNormal];
        _qqFriendButton.backgroundColor = [UIColor whiteColor];
        _qqFriendButton.layer.cornerRadius = 13;
    }
    return _qqFriendButton;
}

- (UIButton *)qZoneButton
{
    if (!_qZoneButton) {
        _qZoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qZoneButton setImage:[UIImage imageNamed:@"qzone_s"] forState:UIControlStateNormal];
        _qZoneButton.backgroundColor = [UIColor whiteColor];
        _qZoneButton.layer.cornerRadius = 13;


    }
    return _qZoneButton;
}
- (UIButton *)bottomButton
{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"取消" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_bottomButton setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomButton;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"分享到";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}
-(UILabel *)wxFriendLabel
{
    if (!_wxFriendLabel) {
        _wxFriendLabel = [UILabel new];
        _wxFriendLabel.text = @"微信好友";
        _wxFriendLabel.textAlignment = NSTextAlignmentCenter;
        _wxFriendLabel.font = [UIFont systemFontOfSize:14];
        _wxFriendLabel.textColor = [UIColor blackColor];
    }
    return _wxFriendLabel;
}
-(UILabel *)wxMomentLabel
{
    if (!_wxMomentLabel) {
        _wxMomentLabel = [UILabel new];
        _wxMomentLabel.text = @"微信朋友圈";
        _wxMomentLabel.textAlignment = NSTextAlignmentCenter;
        _wxMomentLabel.font = [UIFont systemFontOfSize:14];
        _wxMomentLabel.textColor = [UIColor blackColor];
    }
    return _wxMomentLabel;
}
-(UILabel *)qqFriendLabel
{
    if (!_qqFriendLabel) {
        _qqFriendLabel = [UILabel new];
        _qqFriendLabel.text = @"qq好友";
        _qqFriendLabel.textAlignment = NSTextAlignmentCenter;
        _qqFriendLabel.font = [UIFont systemFontOfSize:14];
        _qqFriendLabel.textColor = [UIColor blackColor];
    }
    return _qqFriendLabel;
}
-(UILabel *)qZoneLabel
{
    if (!_qZoneLabel) {
        _qZoneLabel = [UILabel new];
        _qZoneLabel.text = @"qq空间";
        _qZoneLabel.textAlignment = NSTextAlignmentCenter;
        _qZoneLabel.font = [UIFont systemFontOfSize:14];
        _qZoneLabel.textColor = [UIColor blackColor];
    }
    return _qZoneLabel;
}
@end
