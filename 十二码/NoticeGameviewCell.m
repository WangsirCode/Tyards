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
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.left.and.right.equalTo(self.contentView);
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
@end
