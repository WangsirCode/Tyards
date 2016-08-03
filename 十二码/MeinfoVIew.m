//
//  MeinfoVIew.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "MeinfoVIew.h"
#import "MDABizManager.h"
@implementation MeinfoVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self makeconstraits];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.infoImage];
    [self addSubview:self.infoLabel];
}

- (void)makeconstraits
{
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
    }];
    [self.infoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_baseline);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.infoLabel.mas_left).offset(-5);
    }];
}

- (UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:13];
        [_infoLabel setTextColor:[UIColor colorWithHexString:@"#506185"]];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.text = @"修改";
        _infoLabel.numberOfLines = 1;
        _infoLabel.textAlignment = NSTextAlignmentRight;
    }
    return _infoLabel;
}
- (UIButton*)infoImage
{
    if (!_infoImage) {
        _infoImage = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"修个人信息-修改icon"];
        [_infoImage setImage:image forState:UIControlStateNormal];
    }
    return _infoImage;
}
@end
