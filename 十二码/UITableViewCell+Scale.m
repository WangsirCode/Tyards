//
//  UITableViewCell+Scale.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/4.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "UITableViewCell+Scale.h"

@implementation UITableViewCell (Scale)
-(CGFloat)scale
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    return scale;
}
@end
