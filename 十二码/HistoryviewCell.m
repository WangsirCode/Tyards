//
//  HistoryviewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HistoryviewCell.h"

@implementation HistoryviewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view];
    }
    return self;
}

-(NoticeCellView *)myview
{
    if (!_myview) {
        _myview = [[NoticeCellView alloc] initWithFrame:self.contentView.frame];
    }
    return _myview;
}
@end
