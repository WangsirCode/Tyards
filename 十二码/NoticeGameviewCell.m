//
//  NoticeGameviewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NoticeGameviewCell.h"

@implementation NoticeGameviewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view];
        self.contentView.backgroundColor = [UIColor BackGroundColor];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.button];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(10*self.view.scale);
            make.right.equalTo(self.contentView.mas_right).offset(-10*self.view.scale);
            make.height.equalTo(@(156*self.scale));
        }];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@(25*self.view.scale));
        }];
    }
    return self;
}

-(NoticeCellView *)view
{
    if (!_view) {
        _view = [[NoticeCellView alloc] initWithFrame:self.contentView.frame];
    }
    return _view;
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [UIColor BackGroundColor].CGColor;
    }
    return _button;
}
@end
