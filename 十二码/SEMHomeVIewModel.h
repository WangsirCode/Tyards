//
//  SEMHomeVIewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "hotTopicsModel.h"
#import "ReCommendNews.h"
#import "ReactiveCocoa.h"
#import <ReactiveViewModel/ReactiveViewModel.h>
/*!
 *  @author 汪宇豪, 16-07-24 19:07:52
 *
 *  @brief Home界面的Viewmodel
 */
@interface SEMHomeVIewModel : SEMViewModel
@property (nonatomic,strong) NSString   * title;
@property (nonatomic,strong) NSArray<Topic     *> *topics;
@property (nonatomic,strong) NSArray<News      *> *datasource;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) RACCommand * loadNewCommand;
@property (nonatomic,strong) RACCommand * loadMoreCommand;
@property (nonatomic,strong) RACCommand * searchCommand;
@property (nonatomic,strong) NSString* code;
@end
