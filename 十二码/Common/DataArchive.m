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

    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"cache"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath1]) {
        [fileManager createDirectoryAtPath:filePath1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"%@",filePath1);
    NSString *filePath = [filePath1 stringByAppendingPathComponent:aFileName];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aData];
    [archiveData writeToFile:filePath atomically:NO];
}

/*!
 *  @author 汪宇豪, 16-08-08 21:08:59
 *
 *  @brief 存储用户的信息
 *
 *  @param aData     <#aData description#>
 *  @param aFileName <#aFileName description#>
 */
+ (void)archiveUserData:(id<NSCoding>)aData withFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    
    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"user"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath1]) {
        [fileManager createDirectoryAtPath:filePath1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"%@",filePath1);
    NSString *filePath = [filePath1 stringByAppendingPathComponent:aFileName];
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
    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"cache"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath1]) {
        [fileManager createDirectoryAtPath:filePath1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [filePath1 stringByAppendingPathComponent:aFileName];
    id unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return unarchiveData;
}
+ (id<NSCoding>)unarchiveUserDataWithFileName:(NSString *)aFileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"user"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath1]) {
        [fileManager createDirectoryAtPath:filePath1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [filePath1 stringByAppendingPathComponent:aFileName];
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

/*!
 *  @author 汪宇豪, 16-08-08 11:08:14
 *
 *  @brief 删除文件
 *
 *  @param filename 文件名
 */
+ (void)removefile:(NSString *)filename
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"cache"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath1]) {
        [fileManager createFileAtPath:filePath1 contents:nil attributes:nil];
    }
    NSLog(@"%@",filePath1);
    NSString* filePath = [documentPath stringByAppendingPathComponent:filename];
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


/*!
 *  @author 汪宇豪, 16-08-08 11:08:31
 *
 *  @brief 计算文件大校
 *
 *  @param fileName 文件名
 *
 *  @return 大小(单位是M)
 */
+ (unsigned long long)fileSize:(NSString *)fileName
{
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArray safeObjectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    unsigned long long size = 0;
    BOOL isDir = NO;
    BOOL exist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return size;
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:filePath];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
            size += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    return size / 1000000;
}

@end
