//
//  hotTopicsModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
/*!
 *  @author 汪宇豪, 16-07-22 16:07:41
 *
 *  @brief 热点模型
 */
@class Topic,Media;
@interface hotTopicsModel : NSObject<NSCoding>


@property (nonatomic, strong) NSArray<Topic     *> *resp;

@property (nonatomic, assign) NSInteger code;


@end


@interface Topic : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Media     *media;

@property (nonatomic, copy  ) NSString  *title;

@end

@interface Media : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy  ) NSString  *url;

@property (nonatomic, copy  ) NSString  *type;

@end

