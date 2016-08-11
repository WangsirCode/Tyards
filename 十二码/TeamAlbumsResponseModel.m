//
//  TeamAlbumsResponseModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamAlbumsResponseModel.h"

@implementation TeamAlbumsResponseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"resp" : [TeamAlbumModel class]};
}
@end
@implementation TeamAlbumModel

+ (NSDictionary *)objectClassInArray{
    return @{@"firstFour" : [Medias class]};
}

@end


@implementation Medias

@end




@implementation News1

@end


