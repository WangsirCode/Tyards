//
//  ListTableHeaderVIew.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ListTableHeaderVIew.h"
#import "MDABizManager.h"
@implementation ListTableHeaderVIew
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeContraits];
    }
    return self;
}
- (void)makeContraits
{
    
    [self sd_addSubviews:@[self.scoreButton,self.scorerButton,self.awardButton]];
    self.scorerButton.sd_cornerRadiusFromHeightRatio = @0.5;
    self.scoreButton.sd_cornerRadiusFromHeightRatio = @0.5;
    self.awardButton.sd_cornerRadiusFromHeightRatio = @0.5;
    self.scoreButton.sd_layout
    .leftSpaceToView(self,24*self.scale)
    .centerYEqualToView(self)
    .heightIs(24*self.scale)
    .widthIs(69*self.scale);
    self.scorerButton.sd_layout
    .leftSpaceToView(self,144*self.scale)
    .centerYEqualToView(self)
    .heightIs(24*self.scale)
    .widthIs(69*self.scale);
    self.awardButton.sd_layout
    .leftSpaceToView(self,264*self.scale)
    .centerYEqualToView(self)
    .heightIs(24*self.scale)
    .widthIs(69*self.scale);
    
}
- (UIButton *)scoreButton
{
    if (!_scoreButton) {
        _scoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scoreButton setTitle:@"积分榜" forState:UIControlStateNormal];
        [_scoreButton setTitleColor:[UIColor colorWithHexString:@"#A1B2BA"] forState:UIControlStateNormal];
        _scoreButton.layer.borderWidth = 1;
        _scoreButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
        _scoreButton.titleLabel.font = [UIFont systemFontOfSize:12*self.scale];
        [_scoreButton setTitleColor:[UIColor MyColor] forState:UIControlStateSelected];
        [[_scoreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _scoreButton.layer.borderColor = [UIColor MyColor].CGColor;
            _scoreButton.selected = YES;
            [self.delegate didClickButtonAtIndex:0];
            
        }];
    }
    return _scoreButton;
}
- (UIButton *)scorerButton
{
    if (!_scorerButton) {
        _scorerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scorerButton setTitle:@"射手榜" forState:UIControlStateNormal];
        [_scorerButton setTitleColor:[UIColor colorWithHexString:@"#A1B2BA"] forState:UIControlStateNormal];
        [_scorerButton setTitleColor:[UIColor MyColor] forState:UIControlStateSelected];
        _scorerButton.layer.borderWidth = 1;
        _scorerButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
        _scorerButton.titleLabel.font = [UIFont systemFontOfSize:12*self.scale];
        [[_scorerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _scorerButton.layer.borderColor = [UIColor MyColor].CGColor;
            _scorerButton.selected = YES;
            [self.delegate didClickButtonAtIndex:1];
            
        }];
    }
    return _scorerButton;
}
- (UIButton *)awardButton
{
    if (!_awardButton) {
        _awardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_awardButton setTitle:@"奖项" forState:UIControlStateNormal];
        [_awardButton setTitleColor:[UIColor colorWithHexString:@"#A1B2BA"] forState:UIControlStateNormal];
        [_awardButton setTitleColor:[UIColor MyColor] forState:UIControlStateSelected];
        _awardButton.layer.borderWidth = 1;
        _awardButton.layer.borderColor = [UIColor colorWithHexString:@"#A1B2BA"].CGColor;
        _awardButton.titleLabel.font = [UIFont systemFontOfSize:12*self.scale];
        [[_awardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _awardButton.layer.borderColor = [UIColor MyColor].CGColor;
            [self.delegate didClickButtonAtIndex:2];
            _awardButton.selected = YES;
            
        }];
    }
    return _awardButton;
}
@end
