//
//  PhotoCollectionCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            self.titleLabel.text = self.model.name;
            self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.total];
            if (self.model.firstFour[0].media.url) {
                NSURL *url = [[NSURL alloc] initWithString:self.model.firstFour[0].media.url];
                [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.imageView.image = [UIImage placeholderImage];
            }
        }
    }];
}
- (void)makeConstraits
{
    [self.contentView sd_addSubviews:@[self.imageView,self.titleLabel,self.numberLabel]];
    self.imageView.sd_layout
    .topSpaceToView(self.contentView,2)
    .leftSpaceToView(self.contentView,2)
    .rightSpaceToView(self.contentView,2)
    .heightIs(122*self.scale);
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .heightIs(33 *self.scale)
    .topSpaceToView(self.imageView,0)
    .widthIs(100);
    self.numberLabel.sd_layout
    .rightSpaceToView(self.contentView,11)
    .heightIs(33* self.scale)
    .topSpaceToView(self.imageView,0)
    .widthIs(100);
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.font = [UIFont systemFontOfSize:16];
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
