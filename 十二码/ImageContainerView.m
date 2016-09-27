//
//  ImageContainerView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "ImageContainerView.h"
#import "PictureShowController.h"
#import "HZPhotoBrowser.h"
@implementation ImageContainerView

- (instancetype)init
{
    self = [super init];
    if (self ) {
        self.userInteractionEnabled = YES;
        [self setup];
        [self bindModel];
    }
    return self;
}

- (void)setup
{
    
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
          [self addImages];
        }
    }];
}
- (void)addImages
{
    self.height = self.width/3*(self.model.count / 3 + 1);
    [self.model enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[[NSURL alloc] initWithString:obj] placeholderImage:[UIImage placeholderImage]];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
            browserVc.sourceImagesContainerView = self;
            browserVc.imageCount = self.model.count;
            browserVc.currentImageIndex = (int)idx;
            // 代理
            browserVc.delegate = self;
            // 展示图片浏览器
            [browserVc show];
        }];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        imageView.userInteractionEnabled  = YES;
        imageView.sd_layout
        .topSpaceToView(self,(idx/3)*(self.width/3))
        .leftSpaceToView(self,(idx % 3)*(self.width/3))
        .heightIs(self.width / 3 - 6)
        .widthEqualToHeight();
        if (idx == self.model.count - 1 || idx == 8) {
            [self setupAutoHeightWithBottomView:imageView bottomMargin:10];
            *stop = YES;
        }
    }];
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return ((UIImageView*)self.subviews[index]).image;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [[NSURL alloc] initWithString:self.model[index]];
    return url;
}
@end
