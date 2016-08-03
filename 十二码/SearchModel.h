//
//  SearchModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class Area,Universities,Shortcut,Logo;
/*!
 *  @author 汪宇豪, 16-07-24 20:07:33
 *
 *  @brief 搜索返回的结果模型
 */
@interface SearchModel : NSObject<NSCoding>

@property (nonatomic, strong) NSArray<Area      *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface Area : NSObject<NSCoding>

@property (nonatomic, copy  ) NSString     *code;

@property (nonatomic, assign) NSInteger    id;

@property (nonatomic, strong) NSArray<Universities *> *universities;

@property (nonatomic, copy  ) NSString     *name;

@end

@interface Universities : NSObject<NSCoding>

@property (nonatomic, strong) Shortcut  *shortcut;

@property (nonatomic, copy  ) NSString  *city;

@property (nonatomic, copy  ) NSString  *displayName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *code;

@property (nonatomic, copy  ) NSString  *name;

@property (nonatomic, strong) Logo      *logo;

@end

@interface Shortcut : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *url;

@property (nonatomic, copy  ) NSString  *type;

@end

@interface Logo : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *url;

@property (nonatomic, copy  ) NSString  *type;

@end
//@interface SearchResultsModel : NSObject
//
//@property (nonatomic, strong) NSArray<Universities *> *resp;
//
//@property (nonatomic, assign) NSInteger code;
//@end