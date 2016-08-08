//
//  SEMTeamPhotoController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamPhotoController.h"
@interface SEMTeamPhotoController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)TeamPhotoViewModel* viewModel;
@end
@implementation SEMTeamPhotoController
#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    
    // Do any additional setup after loading the view.
}

#pragma viewsetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addSubviews
{
    
}
- (void)makeConstraits
{
    
}
- (void)bindModel
{
    self.navigationItem.title = @"相册";
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[TeamPhotoViewModel alloc] initWithDictionary: routerParameters];
}
@end
