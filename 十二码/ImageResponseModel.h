//
//  ImageResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/9/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageModel;
@interface ImageResponseModel : NSObject
@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) ImageModel* resp;
@end
@interface ImageModel : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString* url;

@end