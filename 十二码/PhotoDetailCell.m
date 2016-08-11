//
//  PhotoDetailCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PhotoDetailCell.h"

@implementation PhotoDetailCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}
- (void)makeConstraits
{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
    }];
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            if (self.model.url) {
                [self.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:self.model.url]  placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.imageView.image = [UIImage placeholderImage];
            }
        }
    }];
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
