//
//  InvitationView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationView.h"

@implementation InvitationView
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
    
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.sd_cornerRadiusFromWidthRatio = @0.5;
    }
    return _imageView;
}

@end
