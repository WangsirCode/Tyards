//
//  GameListView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameListView.h"
#import "MDABizManager.h"
@implementation GameListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sd_addSubviews:@[self.logoImageView,self.titleLabel,self.statusLabel,self.timeLabel]];
        [self bindModel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width / 2;
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(8);
        make.height.and.width.equalTo(@(70 * self.scale));
    }];
    self.titleLabel.sd_layout
    .topSpaceToView(self,22*self.scale)
    .leftSpaceToView(self.logoImageView,12*self.scale)
    .heightIs(18*self.scale);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    self.statusLabel.sd_layout
    .topSpaceToView(self,24*self.scale)
    .leftSpaceToView(self.titleLabel,8 *self.scale)
    .autoHeightRatio(0);
    
    [self.statusLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,12*self.scale)
    .leftSpaceToView(self.logoImageView,12*self.scale)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    if (self.locationView) {
        self.locationView.sd_layout
        .topSpaceToView(self.timeLabel,12*self.scale)
        .leftSpaceToView(self.logoImageView,12*self.scale)
        .heightIs(15*self.scale)
        .widthIs(100);
    }

    
}
- (void)bindModel
{
    [RACObserve(self, status) subscribeNext:^(id x) {
        switch (self.status) {
                //进行中
            case 1:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#1EA11F"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
                self.statusLabel.text = @" 进行中  ";
                break;
                //带开赛
            case 2:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#FD1818"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#FD1818"];
                self.statusLabel.text = @" 待开赛  ";
                break;
                //已结束
            case 3:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#FBC81A"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#FBC81A"];
                self.statusLabel.text = @" 已结束  ";
                break;
       
            default:
                break;
        }
    }];
    [RACObserve(self, location) subscribeNext:^(id x) {
        self.locationView = [[CostomView alloc] initWithInfo:self.location image:[UIImage imageNamed:@"location_L"] FontSize:12];
        self.locationView.label.textColor = [UIColor colorWithHexString:@"999999"];
        [self.locationView.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.locationView.mas_centerY);
            make.left.equalTo(self.locationView.mas_left);
            make.height.equalTo(self.locationView.mas_height).dividedBy(0.9);
            make.width.equalTo(self.locationView.mas_height).dividedBy(1.5);
        }];
        [self addSubview:self.locationView];
    }];
}
#pragma mark- getter
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.layer.masksToBounds = YES;
    }
    return _logoImageView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 16 * self.scale];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12 *self.scale];
        
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12 *self.scale];
        _statusLabel.layer.borderWidth = 1;
    }
    return _statusLabel;
}

@end
