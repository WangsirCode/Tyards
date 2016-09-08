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
        [RACObserve(self, news) subscribeNext:^(id x) {
            if (self.news) {
                UIView* view = [UIView new];
                view.backgroundColor = [UIColor whiteColor];
                view.layer.borderColor = [UIColor BackGroundColor].CGColor;
                view.layer.borderWidth = 0.8;
                [self.contentView addSubview:view];
                view.sd_layout
                .topSpaceToView(self.view,0)
                .leftSpaceToView(self.contentView,10*self.scale)
                .rightSpaceToView(self.contentView,10*self.scale)
                .heightIs(40*self.scale);
                UIImageView* imageview = [UIImageView new];
                imageview.image = [UIImage imageNamed:@"volume"];
                [view addSubview:imageview];
                imageview.sd_layout
                .leftSpaceToView(view,16*self.scale)
                .centerYEqualToView(view)
                .heightIs(13*self.scale)
                .widthEqualToHeight();
                UILabel* label = [UILabel new];
                label.text = self.news;
                label.font = [UIFont systemFontOfSize:13*self.scale];
                [view addSubview:label];
                label.sd_layout
                .centerYEqualToView(view)
                .leftSpaceToView(imageview,8*self.scale)
                .widthIs(300)
                .autoHeightRatio(0);
                
            }
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
