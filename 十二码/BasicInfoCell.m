//
//  BasicInfoCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "BasicInfoCell.h"
#import "MDABizManager.h"
@implementation BasicInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeConstraits];
    }
    return self;
}
- (void)makeConstraits
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.bottomView];
    self.label.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    self.bottomView.sd_layout
    .topSpaceToView(self.label,0)
    .leftSpaceToView(self.contentView,10)
    .rightEqualToView(self.contentView)
    .heightIs(2);
    [self setupAutoHeightWithBottomView:self.bottomView bottomMargin:8];
    
}
- (void)setText:(NSString *)text
{
    _text = text;
    self.label.text = _text;
    
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _label;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];

    }return _bottomView;
}
@end
