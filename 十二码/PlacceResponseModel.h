//
//  PlacceResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaceModel;
@interface PlacceResponseModel : NSObject

@property (nonatomic, strong) NSArray<PlaceModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface PlaceModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@end

