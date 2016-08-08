//
//  SetUpViewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"

@interface SetUpViewModel : SEMViewModel
@property (nonatomic,assign)BOOL isLogined;
@property (nonatomic,strong)NSArray* itemName1;
@property (nonatomic,strong)NSArray* itemName2;
@property (nonatomic,strong)NSString* version;
@property (nonatomic,assign)NSString* fileSize;
- (void)clearCache;
@end
