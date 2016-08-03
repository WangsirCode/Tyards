//
//  TagView.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TagView.h"
#import "MDABizManager.h"
@implementation TagView
- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//- (NSMutableArray<UILabel *> *)labels
//{
//    if (!_labels) {
//        NSInteger count = self.tagArray.count;
//        _labels = [[NSMutableArray alloc] init];
//        [self.tagArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSInteger count = obj.length;
//            UILabel* laebel = [[UILabel alloc] init];
//            laebel.font = [UIFont systemFontOfSize:16];
//            laebel.textColor = [UIColor colorWithHexString:@"#1EA11F"];
//            laebel.text = obj;
//            laebel.layer.borderWidth = 1;
//            laebel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            [self addSubview:laebel];
//            [_labels addObject:laebel];
//            if (count < 4) {
//                
//            }
////            [laebel mas_makeConstraints:^(MASConstraintMaker *make) {
////                if (<#condition#>) {
////                    <#statements#>
////                }
////            }];
////        }];
//    }
//    return _labels;
//}
@end
