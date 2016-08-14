//
//  InfoViewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InfoViewCell.h"
#import "MDABizManager.h"
@implementation InfoViewCell
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
    [self.contentView sd_addSubviews:@[self.label,self.bottomView]];
    [self.bottomView sd_addSubviews:@[self.heightButton,self.weightButton,self.positionButton]];
    self.label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    self.bottomView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.label,16*self.scale)
    .heightIs(76*self.scale);
    
    self.heightButton.sd_layout
    .topEqualToView(self.bottomView)
    .leftEqualToView(self.bottomView)
    .bottomEqualToView(self.bottomView)
    .widthIs([UIScreen mainScreen].bounds.size.width / 3);
    
    self.weightButton.sd_layout
    .topEqualToView(self.bottomView)
    .leftSpaceToView(self.heightButton,0)
    .bottomEqualToView(self.bottomView)
    .widthIs([UIScreen mainScreen].bounds.size.width / 3);
    
    self.positionButton.sd_layout
    .topEqualToView(self.bottomView)
    .leftSpaceToView(self.weightButton,0)
    .bottomEqualToView(self.bottomView)
    .widthIs([UIScreen mainScreen].bounds.size.width / 3);
    
    [self setupAutoHeightWithBottomView:self.bottomView bottomMargin:0];
    
    
}
- (void)setModel:(PlayerDetail *)model
{
    _model = model;
    if (_model.desc) {
        self.label.text = _model.desc;
    }
    else
    {
        self.label.text = @"";
    }
    self.weightButton.dataLabel.text = [_model weightInfo];
    self.heightButton.dataLabel.text = [_model heightInfo];
    self.positionButton.dataLabel.text = [_model PosionInfo];
}
- (UILabel *)label
{
    if(!_label)
    {
        _label = [UILabel new];
        _label.textColor = [UIColor colorWithHexString:@"#666666"];
        _label.font = [UIFont systemFontOfSize:16];
    }
    return _label;
}
- (UIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [UIView new];
        _bottomView.layer.borderWidth = 1;
        _bottomView.layer.borderColor = [UIColor BackGroundColor].CGColor;
    }
    return _bottomView;
}
- (BottomButton *)heightButton
{
    if (!_heightButton) {
        _heightButton = [[BottomButton alloc] init];
        _heightButton.infoLabel.text = @"身高";
    }
    return _heightButton;
}
- (BottomButton *)weightButton
{
    if (!_weightButton) {
        _weightButton = [[BottomButton alloc] init];
        _weightButton.infoLabel.text = @"体重";
    }
    return _weightButton;
}
- (BottomButton *)positionButton
{
    if (!_positionButton) {
        _positionButton = [[BottomButton alloc] init];
        _positionButton.infoLabel.text = @"位置";
    }
    return _positionButton;
}
@end
@implementation BottomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView* line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self sd_addSubviews:@[self.infoLabel,self.dataLabel,line]];
        self.dataLabel.sd_layout
        .rightEqualToView(self)
        .topSpaceToView(self,23*self.scale)
        .leftEqualToView(self)
        .heightIs(20*self.scale);
        
        self.infoLabel.sd_layout
        .rightEqualToView(self)
        .leftEqualToView(self)
        .topSpaceToView(self.dataLabel,8)
        .heightIs(20*self.scale);
        
        line.sd_layout
        .widthIs(1)
        .heightIs(20*self.scale)
        .rightEqualToView(self)
        .centerYEqualToView(self);
    }
    return self;
}
- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.textColor = [UIColor colorWithHexString:@"A1B2BA"];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

- (UILabel *)dataLabel
{
    if (!_dataLabel) {
        _dataLabel = [UILabel new];
        _dataLabel.font = [UIFont systemFontOfSize:16];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#104D30"];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dataLabel;
}
@end