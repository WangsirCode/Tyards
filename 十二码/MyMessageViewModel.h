//
//  MyMessageViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/7.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "MyMessageModel.h"
@interface MyMessageViewModel : SEMViewModel
@property (nonatomic,assign)BOOL shouldReloadDate;
@property (nonatomic, strong) NSArray<Resp *> *model;
@end
