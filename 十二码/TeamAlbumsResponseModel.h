//
//  TeamAlbumsResponseModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDABizManager.h"
@class TeamAlbumModel,Medias,News1;
@interface TeamAlbumsResponseModel : NSObject

@property (nonatomic, strong) NSArray<TeamAlbumModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end
@interface TeamAlbumModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSArray<Medias *> *firstFour;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL reserve;

@property (nonatomic, assign) NSInteger total;

@end

@interface Medias : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) Media *media;

@property (nonatomic, strong) News1 *news;

@end


@interface News1 : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) long long dateCreated;

@property (nonatomic, assign) NSInteger viewed;

@end

