//
//  NSArray+Safe.m
//  RealEstate
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

+ (instancetype)safeArrayWithObject:(id)object
{
    if (object == nil) {
        return [self array];
    } else {
        return [self arrayWithObject:object];
    }
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range
{
    NSInteger location = range.location;
    NSInteger length = range.length;
    if (location<0 || length<0 || location+length>self.count) {
        return nil;
    } else {
        return [self subarrayWithRange:range];
    }
}

@end
