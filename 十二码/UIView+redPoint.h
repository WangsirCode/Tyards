//
//  UIView+redPoint.h
//  十二码
//
//  Created by 汪宇豪 on 2016/10/15.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (redPoint)
- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY OrValue:(NSString *)value;
- (void)hideRedPoint;
@end
