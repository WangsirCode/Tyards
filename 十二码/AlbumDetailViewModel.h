//
//  AlbumDetailViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface AlbumDetailViewModel : SEMViewModel
@property (nonatomic, strong) AlbumModel *model;
@property (nonatomic,strong ) NSString   * title;
@property (nonatomic, strong) NSMutableArray<Medias *> *medias;
@property (nonatomic,assign) NSInteger number;
@end
