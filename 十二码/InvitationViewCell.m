//
//  InvitationViewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/30.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationViewCell.h"

@implementation InvitationViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view];
        self.view.sd_layout
        .topSpaceToView(self.contentView,12*self.view.scale)
        .leftSpaceToView(self.contentView,12*self.view.scale)
        .rightSpaceToView(self.contentView,12*self.view.scale)
        .bottomEqualToView(self.contentView);
    }
    return self;
}
- (InvitationView *)view
{
    if (!_view) {
        _view = [[InvitationView alloc] init];
    }
    return _view;
}
@end
