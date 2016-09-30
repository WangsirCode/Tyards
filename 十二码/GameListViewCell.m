//
//  GameListViewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "GameListViewCell.h"
#import "MDABizManager.h"
@implementation GameListViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView sd_addSubviews:@[self.logoImageView,self.titleLabel,self.statusLabel,self.timeLabel]];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}

- (void)makeConstraits
{

    self.logoImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10)
    .heightIs((self.scale * 70))
    .widthEqualToHeight()
    ;
    self.logoImageView.sd_cornerRadiusFromHeightRatio = @0.5;
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView,22*self.scale)
    .leftSpaceToView(self.logoImageView,12*self.scale)
    .heightIs(18*self.scale);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    self.statusLabel.sd_layout
    .topSpaceToView(self.contentView,24*self.scale)
    .leftSpaceToView(self.titleLabel,8 *self.scale)
    .widthIs(40*self.scale)
    .heightIs(18*self.scale);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,12*self.scale)
    .leftSpaceToView(self.logoImageView,12*self.scale)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    self.locationView = [[CostomView alloc] initWithInfo:self.location image:[UIImage imageNamed:@"location_L"] FontSize:12];
    self.locationView.label.textColor = [UIColor colorWithHexString:@"999999"];
    [self.contentView addSubview:self.locationView];
    self.locationView.sd_layout
    .topSpaceToView(self.timeLabel,12*self.scale)
    .leftSpaceToView(self.logoImageView,12*self.scale)
    .heightIs(15*self.scale)
    .widthIs(100);
    [self.locationView.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationView.mas_centerY);
        make.left.equalTo(self.locationView.mas_left);
        make.height.equalTo(self.locationView.mas_height).dividedBy(1);
        make.width.equalTo(self.locationView.mas_height).dividedBy(1.5);
    }];
}
- (void)bindModel
{
    [RACObserve(self, status) subscribeNext:^(id x) {
        switch (self.status) {
                //进行中
            case 1:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#1EA11F"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
                self.statusLabel.text = @"进行中";
                break;
                //带开赛
            case 2:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#FD1818"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#FD1818"];
                self.statusLabel.text = @"待开赛";
                break;
                //已结束
            case 3:
                self.statusLabel.layer.borderColor = [UIColor colorWithHexString:@"#FBC81A"].CGColor;
                self.statusLabel.textColor = [UIColor colorWithHexString:@"#FBC81A"];
                self.statusLabel.text = @"已结束";
                break;
                
            default:
                break;
        }
    }];
    [RACObserve(self, location) subscribeNext:^(id x) {
        if (self.location) {
            self.locationView.label.text = self.location;
        }
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

- (MyLabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[MyLabel alloc] init];
        _statusLabel.textInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        _statusLabel.font = [UIFont systemFontOfSize:9 *self.scale];
        _statusLabel.layer.borderWidth = 1;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
@end
