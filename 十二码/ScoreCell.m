//
//  ScoreCell.m
//  十二码
//
//  Created by 汪宇豪 on 2016/9/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ScoreCell.h"
#import "MDABizManager.h"
#import "SEMTeamHomeViewController.h"
@implementation ScoreCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.delegate didClickButton];
        }];
        [self.label addGestureRecognizer:tap];
    }
    return self;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor MyColor];
        
    }
    return _label;
}

@end
