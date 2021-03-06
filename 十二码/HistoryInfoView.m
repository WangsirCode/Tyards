//
//  HistoryInfoView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HistoryInfoView.h"

@implementation HistoryInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubvies];
        [self makeConstraits];
        [self bindModel];
        self.layer.borderColor = [UIColor BackGroundColor].CGColor;
        self.layer.borderWidth = 0.5;
        
    }
    return self;
}
- (void)addSubvies
{
//    [self addSubview:self.titleLabel];
//    [self addSubview:self.roundLabel];
    [self addSubview:self.homeImageview];
    [self addSubview:self.awayImgaeview];
    [self addSubview:self.homeTitleLabel];
    [self addSubview:self.awayTitleLabel];
    [self addSubview:self.homeScoreLabel];
    [self addSubview:self.awaySocreLabel];
    [self addSubview:self.centerLabel];
    [self addSubview:self.locationImageView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.timeImageView];
    [self addSubview:self.homeLabel];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.homeImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(60*scale);
        make.centerY.equalTo(self.mas_top).offset(40*scale);
        make.width.and.height.equalTo(@(54*scale));
    }];
    [self.awayImgaeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_right).offset(-60*scale);
        make.centerY.equalTo(self.mas_top).offset(40*scale);
        make.width.and.height.equalTo(@(54*scale));
    }];
    [self.homeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.homeImageview.mas_centerX);
        make.top.equalTo(self.homeImageview.mas_bottom).offset(12*scale);
    }];
    [self.awayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayImgaeview.mas_centerX);
        make.top.equalTo(self.awayImgaeview.mas_bottom).offset(12*scale);
    }];
    [self.homeScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(40*scale);
        make.left.equalTo(self.homeImageview.mas_right).offset(42*scale);
    }];
    [self.awaySocreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(40*scale);
        make.right.equalTo(self.awayImgaeview.mas_left).offset(-42*scale);
    }];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.homeScoreLabel.mas_centerY);
    }];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10*scale));
        make.width.equalTo(@(7*scale));
        make.top.equalTo(self.homeTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(8*self.scale);
    }];
    [self.homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImageView.mas_right).offset(10*self.scale);
        make.top.equalTo(self.locationImageView.mas_top);
        make.bottom.equalTo(self.locationImageView.mas_bottom);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerLabel.mas_right).offset(10);
        make.top.equalTo(self.locationImageView.mas_top);
        make.bottom.equalTo(self.locationImageView.mas_bottom);
    }];
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10*scale));
        make.width.equalTo(@(10*scale));
        make.top.equalTo(self.homeTitleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.timeLabel.mas_left).offset(-8);
    }];

}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            self.homeTitleLabel.text = self.model.home.name;
            self.awayTitleLabel.text = self.model.away.name;
            self.homeScoreLabel.text = [@(self.model.homeScore) stringValue];
            self.awaySocreLabel.text = [@(self.model.awayScore) stringValue];
            if (self.model.home.logo.url) {
                [self.homeImageview sd_setImageWithURL:[[NSURL alloc] initWithString:self.model.home.logo.url] placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.homeImageview.image = [UIImage placeholderImage];
            }
            if (self.model.away.logo.url) {
                [self.awayImgaeview sd_setImageWithURL:[[NSURL alloc] initWithString:self.model.away.logo.url] placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.awayImgaeview.image = [UIImage placeholderImage];
            }
            self.homeLabel.text = self.model.tournament.name;
            self.timeLabel.text = [self.model getDate];
        }
    }];
}
//- (UILabel*)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont systemFontOfSize:18];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        
//    }
//    return _titleLabel;
//}
//
//- (UILabel *)roundLabel
//{
//    if (!_roundLabel) {
//        _roundLabel = [[UILabel alloc] init];
//        _roundLabel.font = [UIFont systemFontOfSize:11];
//        _roundLabel.textAlignment = NSTextAlignmentCenter;
//        _roundLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//    }
//    return _roundLabel;
//}

- (UIImageView *)homeImageview
{
    if (!_homeImageview) {
        _homeImageview = [[UIImageView alloc] init];
        _homeImageview.layer.masksToBounds = YES;
    }
    return _homeImageview;
}
- (UIImageView *)awayImgaeview
{
    if (!_awayImgaeview) {
        _awayImgaeview = [[UIImageView alloc] init];
        _awayImgaeview.layer.masksToBounds = YES;
    }
    return _awayImgaeview;
}
- (UILabel *)homeTitleLabel
{
    if (!_homeTitleLabel) {
        _homeTitleLabel = [[UILabel alloc] init];
        _homeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _homeTitleLabel.font = [UIFont systemFontOfSize:14*self.scale];
    }
    return _homeTitleLabel;
}
- (UILabel *)awayTitleLabel
{
    if (!_awayTitleLabel) {
        _awayTitleLabel = [[UILabel alloc] init];
        _awayTitleLabel.textAlignment = NSTextAlignmentCenter;
        _awayTitleLabel.font = [UIFont systemFontOfSize:14*self.scale];
    }
    return _awayTitleLabel;
}
- (UILabel *)homeScoreLabel
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    if (!_homeScoreLabel) {
        _homeScoreLabel = [[UILabel alloc] init];
        _homeScoreLabel.textAlignment = NSTextAlignmentCenter;
        _homeScoreLabel.font = [UIFont systemFontOfSize:(NSInteger)(28*scale)];
    }
    return _homeScoreLabel;
    
}
- (UILabel *)awaySocreLabel
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    if (!_awaySocreLabel) {
        _awaySocreLabel = [[UILabel alloc] init];
        _awaySocreLabel.textAlignment = NSTextAlignmentCenter;
        _awaySocreLabel.font = [UIFont systemFontOfSize:(NSInteger)(28*scale)];
    }
    return _awaySocreLabel;
}
- (UILabel *)centerLabel
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = [UIFont systemFontOfSize:(NSInteger)(28*scale)];
        _centerLabel.text = @":";
    }
    return _centerLabel;
}
//-(UILabel *)statusLabel
//{
//    if (!_statusLabel) {
//        _statusLabel = [[UILabel alloc] init];
//        _statusLabel.font = [UIFont systemFontOfSize:11];
//        _statusLabel.textAlignment = NSTextAlignmentCenter;
//        _statusLabel.layer.borderWidth = 1;
//    }
//    return _statusLabel;
//}
- (UIImageView *)locationImageView
{
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.image = [UIImage imageNamed:@"赛事icon=灰"];
    }
    return _locationImageView;
}
- (UILabel *)homeLabel
{
    if (!_homeLabel) {
        _homeLabel = [[UILabel alloc] init];
        _homeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _homeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _homeLabel;
}
- (UIImageView *)timeImageView
{
    if (!_timeImageView) {
        _timeImageView = [UIImageView new];
        _timeImageView.image = [UIImage imageNamed:@"clock"];
    }
    return _timeImageView;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _timeLabel;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.homeImageview.layer.cornerRadius = self.homeImageview.width / 2;
    self.awayImgaeview.layer.cornerRadius = self.awayImgaeview.width / 2;
}

@end
