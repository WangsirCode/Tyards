//
//  TopicCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
        self.scale = [data floatForKey:@"scale"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}
- (void)addSubviews
{
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)makeConstraits
{
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.equalTo(@(188 * self.scale));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_bottom).offset(10 * self.scale);
        make.left.equalTo(self.contentView.mas_left).offset(12 * self.scale);
        make.right.equalTo(self.contentView.mas_right).offset(-12 * self.scale);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10 * self.scale);
        make.left.equalTo(self.contentView.mas_left).offset(10*self.scale);
        make.right.equalTo(self.contentView.mas_right).offset(10*self.scale);
        make.height.equalTo(@(18 * self.scale));
    }];
}

- (void)bindModel
{
    [RACObserve(self, titleImageURL) subscribeNext:^(NSString* x) {
        if (x) {
            NSURL* url = [[NSURL alloc] initWithString:x];
            [self.titleImageView sd_setImageWithURL:url
                                   placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                            options:SDWebImageRefreshCached];
        }
        else
        {
            self.titleImageView.image = [UIImage imageNamed:@"zhanwei"];
        }
    }];
    RAC(self.titleLabel,text) = RACObserve(self, title);
    RAC(self.bottomView.commentLabel,text) = RACObserve(self, comment);
    RAC(self.bottomView.inifoLabel,text) = RACObserve(self, info);
}
- (BottomView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc] initWithFrame:CGRectZero];
        
    }
    return _bottomView;
}
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =[UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIImageView*)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
        [_titleImageView setUserInteractionEnabled:YES];
    }
    return _titleImageView;
}
@end
