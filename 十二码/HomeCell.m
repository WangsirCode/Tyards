//
//  HomeCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HomeCell.h"
#import "Masonry.h"
#import "MDABizManager.h"
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self makeConstraits];
    }
    return self;
}


#pragma mark - viewsetup
- (void)addSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.newsImage];
    [self.contentView addSubview:self.bottomview];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10*scale);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10*scale);
        make.left.equalTo(self.contentView.mas_left).offset(10*scale);
        make.width.equalTo(self.contentView.mas_width).dividedBy(3.7);
    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(10 * scale);
//        make.left.equalTo(self.newsImage.mas_right).offset(4*scale);
//        make.right.equalTo(self.contentView.mas_right).offset(-10*scale);
//        make.height.equalTo(@(60 * scale));
//    }];
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView,10*self.scale)
    .leftSpaceToView(self.newsImage,4*self.scale)
    .rightSpaceToView(self.contentView,10*self.scale)
    .autoHeightRatio(0)
    .maxHeightIs(60*self.scale);
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-6*scale);
        make.height.equalTo(@(20*self.scale));
    }];
    
}

#pragma mark -getter
- (UILabel*)titleLabel
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18*scale];
        _titleLabel.alpha = 0.87;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView* )newsImage
{
    if (!_newsImage){
        _newsImage = [[UIImageView alloc] init];
    }
    return _newsImage;
}
- (BottomView*)bottomview
{
    if (!_bottomview) {
        _bottomview = [[BottomView alloc] init];
    }
    return _bottomview;
}
@end
