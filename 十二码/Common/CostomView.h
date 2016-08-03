//
//  CostomButton.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/3.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomView : UIView;
@property (nonatomic,strong) UILabel     * label;
@property (nonatomic,strong) NSString    * text;
@property (nonatomic,strong) UIImage     * imgae;
@property (nonatomic,strong) UIImageView * imageView;
- (instancetype)initWithInfo:(NSString*)text image:(UIImage*)image;
@end
