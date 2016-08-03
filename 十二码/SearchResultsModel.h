//
//  SearchResultsModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/24.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
#import "MJExtension.h"
@interface SearchResultsModel : NSObject

@property (nonatomic, strong) NSArray<Universities *> *resp;

@property (nonatomic, assign) NSInteger code;
@end

