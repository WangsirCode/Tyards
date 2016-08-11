//
//  OvalVIew.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "OvalView.h"
#define PI 3.14159265358979323846
@implementation OvalView

- (instancetype)initWithData:(Record*)data
{
    self = [super init];
    if (self) {
        self.model = data;
        self.backgroundColor = [UIColor whiteColor];
        [self setNeedsDisplay];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y + 0.5 * rect.size.height);
    CGFloat end1;
    CGFloat end2;
    CGFloat totle= self.model.wins + self.model.loses + self.model.draws;
    if (totle == 0) {
        end1 = 2 * PI / 3;
        end2 = 2 * PI / 3 + end1;
    }
    else
    {
        end1 = 2 * PI * (self.model.loses / totle);
        end2 = 2 * PI * (self.model.draws / totle) + end1;
    }
    
    CGContextMoveToPoint(context, center.x, center.y);//移动画笔到指定坐标点
    UIColor* aColor = [UIColor colorWithHexString:@"#76D1B6"];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextAddArc(context, center.x, center.y, 80*self.scale, 0 - PI / 2, end1 - PI / 2, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextMoveToPoint(context, center.x, center.y);//移动画笔到指定坐标点
    UIColor* bColor = [UIColor colorWithHexString:@"#DAF1B4"];
    CGContextSetFillColorWithColor(context, bColor.CGColor);//填充颜色
    CGContextAddArc(context, center.x, center.y, 80*self.scale, end1 - PI / 2, end2 - PI / 2, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);
//
    CGContextMoveToPoint(context, center.x, center.y);//移动画笔到指定坐标点
    UIColor* cColor = [UIColor colorWithRed:156/255.0 green:222/255.0 blue:154/255.0 alpha:1];
    CGContextSetFillColorWithColor(context, cColor.CGColor);//填充颜色
    CGContextAddArc(context, center.x, center.y, 80*self.scale, end2 - PI / 2, 2 *PI- PI / 2, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextMoveToPoint(context, center.x, center.y);//移动画笔到指定坐标点
    UIColor* dColor = [UIColor BackGroundColor];
    CGContextSetFillColorWithColor(context, dColor.CGColor);//填充颜色
    CGContextAddArc(context, center.x, center.y, 50*self.scale, 0, 2 *PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);

}
@end
