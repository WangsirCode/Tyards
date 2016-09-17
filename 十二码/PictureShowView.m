//
//  PictureShowView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PictureShowView.h"
#import "MDABizManager.h"
@implementation PictureShowView

- (instancetype)initWithImages:(NSArray<UIImage *> *)images
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpView:images];
    }
    return self;
}
- (void)setUpView:(NSArray<UIImage *> *)images
{
    if (images.count == 9) {
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView* imageView = [UIImageView new];
            imageView.image = obj;
            [self addSubview:imageView];
            imageView.sd_layout
            .topSpaceToView(self,(idx / 5)*60*self.scale + 10 *self.scale)
            .widthIs(50*self.scale)
            .heightIs(50*self.scale)
            .leftSpaceToView(self,(idx % 5)*60*self.scale + 10*self.scale);
            if (idx == 8) {
                [self setupAutoHeightWithBottomView:imageView bottomMargin:10];
            }
        }];
    }
    else
    {
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView* imageView = [UIImageView new];
            imageView.image = obj;
            [self addSubview:imageView];
            imageView.sd_layout
            .topSpaceToView(self,(idx / 5)*60*self.scale + 10 *self.scale)
            .widthIs(50*self.scale)
            .heightIs(50*self.scale)
            .leftSpaceToView(self,(idx % 5)*60*self.scale + 10*self.scale);
        }];
        NSInteger i = images.count;
        self.addImageView = [UIImageView new];
        self.addImageView.image = [UIImage imageNamed:@"➕图片"];
        [self addSubview:self.addImageView];
        self.addImageView.sd_layout
        .topSpaceToView(self,(i / 5)*60*self.scale + 10 *self.scale)
        .widthIs(50*self.scale)
        .heightIs(50*self.scale)
        .leftSpaceToView(self,(i % 5)*60*self.scale + 10*self.scale);
        self.addImageView.userInteractionEnabled = YES;
        [self setupAutoHeightWithBottomView:self.addImageView bottomMargin:10];
    }
}
@end
