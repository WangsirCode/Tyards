//
//  MyMessageCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MyMessageCell.h"

@implementation MyMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeConstraits];
        [self bindModel];
    }
    return  self;
}
- (void)makeConstraits
{
    [self.contentView sd_addSubviews:@[self.label,self.logoImageView,self.detailLabel,self.dateLabel]];
    self.logoImageView.sd_layout
    .leftSpaceToView(self.contentView,12 * self.contentView.scale)
    .centerYEqualToView(self.contentView)
    .heightIs(40* self.contentView.scale)
    .widthEqualToHeight();
    
    self.logoImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    self.label.sd_layout
    .topSpaceToView(self.contentView,18 * self.contentView.scale)
    .leftSpaceToView(self.logoImageView,12 * self.contentView.scale)
    .autoHeightRatio(0)
    .widthIs(150);
    
    self.detailLabel.sd_layout
    .leftSpaceToView(self.logoImageView,12 * self.contentView.scale)
    .topSpaceToView(self.label,12 * self.contentView.scale)
    .rightEqualToView(self.contentView)
    .heightIs(20 * self.contentView.scale);
    
    self.dateLabel.sd_layout
    .rightSpaceToView(self.contentView,12)
    .widthIs(150)
    .topSpaceToView(self.contentView,18 * self.contentView.scale)
    .autoHeightRatio(0);
    
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        self.label.text = self.model.creator.nickname;
        self.detailLabel.text = self.model.content;
        if (self.model.creator.avatar) {
            NSURL* url = [[NSURL alloc] initWithString:self.model.creator.avatar];
            [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage placeholderImage]];
        }
        else
        {
            self.logoImageView.image = [UIImage placeholderImage];
        }
        self.dateLabel.text = [self.model getdate];
        
    }];
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
    }
    return _logoImageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor MyColor];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}
- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _detailLabel;
}
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}
@end
