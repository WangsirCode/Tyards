//
//  DataArchive.m
//  SmartCommunity
//
//  Created by apple on 15/3/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DataArchive.h"
#import "NSArray+Safe.h"
@implementation DataArchive

/**
 *  功能:存档（缓存用户数据）
 */
+ (void)archiveData:(id<NSCoding>)aData withFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aData];
    [archiveData writeToFile:filePath atomically:NO];
}

/**
 *  功能:取档(获取用户数据，第一次使用或版本更新时会清空数据)
 */
+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    
    id unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return unarchiveData;
}

/**
 *  功能:取档(获取系统数据，直接取档)
 */
+ (id<NSCoding>)unarchiveSystemDataWithFileName:(NSString *)aFileName
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:aFileName];
    id unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return unarchiveData;
}
+ (void)removefile:(NSString *)filename
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:filename];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:filePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
}


    
@end
