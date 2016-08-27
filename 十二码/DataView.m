//
//  DataView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "DataView.h"
#import "MDABizManager.h"
@implementation DataView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeConstraits];
    }
    return self;
}
- (void)makeConstraits
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor BackGroundColor].CGColor;
    [self sd_addSubviews:@[self.titleLabel,self.numTitileLabel,self.winTitleLabel,self.loseLabel,self.loseTitleLabel,self.drawTitleLabel,self.numLabel,self.winLabel,self.drawLabel]];
    self.titleLabel.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(48*self.scale);
    
    self.numTitileLabel.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self.titleLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.winTitleLabel.sd_layout
    .leftSpaceToView(self,84*self.scale)
    .topSpaceToView(self.titleLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.drawTitleLabel.sd_layout
    .leftSpaceToView(self,168*self.scale)
    .topSpaceToView(self.titleLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.loseTitleLabel.sd_layout
    .leftSpaceToView(self,252*self.scale)
    .topSpaceToView(self.titleLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.numLabel.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self.numTitileLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.winLabel.sd_layout
    .leftSpaceToView(self,84*self.scale)
    .topSpaceToView(self.numTitileLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.drawLabel.sd_layout
    .leftSpaceToView(self,168*self.scale)
    .topSpaceToView(self.numTitileLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);
    
    self.loseLabel.sd_layout
    .leftSpaceToView(self,252*self.scale)
    .topSpaceToView(self.numTitileLabel,0)
    .heightIs(48*self.scale)
    .widthIs(84*self.scale);

}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.borderColor = [UIColor BackGroundColor].CGColor;
    }
    return _titleLabel;
}
- (UILabel *)numTitileLabel
{
    if (!_numTitileLabel) {
        _numTitileLabel = [UILabel new];
        _numTitileLabel.text = @"场次";
        _numTitileLabel.textAlignment = NSTextAlignmentCenter;
        _numTitileLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _numTitileLabel.font = [UIFont systemFontOfSize:14];
    }
    return _numTitileLabel;
}
- (UILabel *)winTitleLabel
{
    if (!_winTitleLabel) {
        _winTitleLabel = [UILabel new];
        _winTitleLabel.text = @"胜";
        _winTitleLabel.textAlignment = NSTextAlignmentCenter;
        _winTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _winTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _winTitleLabel;
}
- (UILabel *)loseTitleLabel
{
    if (!_loseTitleLabel) {
        _loseTitleLabel = [UILabel new];
        _loseTitleLabel.text = @"负";
        _loseTitleLabel.textAlignment = NSTextAlignmentCenter;
        _loseTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _loseTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _loseTitleLabel;
}
- (UILabel *)drawTitleLabel
{
    if (!_drawTitleLabel) {
        _drawTitleLabel = [UILabel new];
        _drawTitleLabel.text = @"平";
        _drawTitleLabel.textAlignment = NSTextAlignmentCenter;
        _drawTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _drawTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _drawTitleLabel;
}
- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.alpha = 0.87;
    }
    return _numLabel;
}
- (UILabel *)winLabel
{
    if (!_winLabel) {
        _winLabel = [UILabel new];
        _winLabel.textAlignment = NSTextAlignmentCenter;
        _winLabel.font = [UIFont systemFontOfSize:14];
        _winLabel.alpha = 0.87;
    }
    return _winLabel;
}
- (UILabel *)loseLabel
{
    if (!_loseLabel) {
        _loseLabel = [UILabel new];
        _loseLabel.textAlignment = NSTextAlignmentCenter;
        _loseLabel.font = [UIFont systemFontOfSize:14];
        _loseLabel.alpha = 0.87;
    }
    return _loseLabel;
}
- (UILabel *)drawLabel
{
    if (!_drawLabel) {
        _drawLabel = [UILabel new];
        _drawLabel.textAlignment = NSTextAlignmentCenter;
        _drawLabel.font = [UIFont systemFontOfSize:14];
        _drawLabel.alpha = 0.87;
    }
    return _drawLabel;
}

@end
