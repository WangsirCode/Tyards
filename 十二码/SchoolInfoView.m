//
//  SchoolInfoView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SchoolInfoView.h"
#import "MDABizManager.h"
@implementation SchoolInfoView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}

- (void)addSubviews
{
    [self addSubview:self.logoImgaeView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scoreLabel];
}

- (void)makeConstraits
{
    
}
 - (void)bindModel
{
    [RACObserve(self, imageURL) subscribeNext:^(NSString* x) {
        if (x) {
            NSURL* url = [[NSURL alloc] initWithString:x];
            [self.logoImgaeView sd_setImageWithURL:url
                                   placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                            options:SDWebImageRefreshCached];
        }
        else
        {
            self.logoImgaeView.image = [UIImage imageNamed:@"zhanwei"];
        }
    }];
    RAC(self.nameLabel,text) = RACObserve(self, name);
    RAC(self.scoreLabel,text) = RACObserve(self, score);
}


#pragma mark- Getter
- (UIImageView*)logoImgaeView
{
    if (!_logoImgaeView) {
        _logoImgaeView = [[UIImageView alloc] init];
        
    }
    return _logoImgaeView;
}
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}
- (UILabel*)scoreLabel
{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = [UIFont systemFontOfSize:30];
    }
    return _scoreLabel;
}
@end
