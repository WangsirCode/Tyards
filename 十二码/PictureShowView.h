//
//  PictureShowView.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/14.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PictureShowView : UIView
- (instancetype)initWithImages:(NSArray<UIImage*>*) images;
@property (nonatomic,strong) UIImageView* addImageView;
@end
