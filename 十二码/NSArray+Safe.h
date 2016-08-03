//
//  NSArray+Safe.h
//  RealEstate
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

/**
 * 安全处理
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

+ (instancetype)safeArrayWithObject:(id)object;

- (NSArray *)safeSubarrayWithRange:(NSRange)range;

@end
