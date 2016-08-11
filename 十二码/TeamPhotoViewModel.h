//
//  TeamPhotoViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
@interface TeamPhotoViewModel : SEMViewModel
@property (nonatomic, strong) NSArray<TeamAlbumModel *> *model;
@end
