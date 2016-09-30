//
//  CostomButton.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CostomView.h"
#import "MDABizManager.h"
@implementation CostomView
- (instancetype)initWithInfo:(NSString*)text image:(UIImage*)image FontSize:(NSInteger)size
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.label.text = text;
        self.imageView.image = image;
        self.label.font = [UIFont systemFontOfSize:size];
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height).dividedBy(1.2);
        make.width.equalTo(self.mas_height).dividedBy(1);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(8);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
        make.right.equalTo(self.mas_right);
    }];
}
- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.userInteractionEnabled = YES;
    }
    return _label;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc ] init];
    }
    return _imageView;
}
@end
