//
//  SEMTeamPhotoController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamPhotoController.h"
#import "PhotoCollectionCell.h"
#import "AlbumDetailController.h"
@interface SEMTeamPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) TeamPhotoViewModel *viewModel;
@property (nonatomic,strong) UICollectionView   *collectionView;
@property (nonatomic,strong) UIBarButtonItem    *backItem;
@property (nonatomic,strong) MBProgressHUD      *hud;
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
    self.hud.labelText = @"加载中";
    [self addSubviews];
    [self makeConstraits];
    
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view sd_addSubviews:@[self.collectionView]];
}
- (void)makeConstraits
{
//    self.collectionView.sd_layout
//    .topEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view)
//    .bottomEqualToView(self.view);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)bindModel
{
    self.navigationItem.title = @"相册";
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            [self.collectionView reloadData];
            [self.hud hide:YES];
        }
    }];
}

#pragma mark-collectiondatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionCell* cell = (PhotoCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionCell class]) forIndexPath:indexPath];
    cell.model = self.viewModel.model[indexPath.row];
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20*self.view.scale, 14, 0, 14);
}
#pragma mark -collectionviewDatasource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionCell* cell = (PhotoCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    AlbumDetailController* controller = [[AlbumDetailController alloc] initWithDictionary:@{@"id":@(cell.model.id),@"title":cell.model.name}];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[TeamPhotoViewModel alloc] initWithDictionary: routerParameters];
}

#pragma mark- getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {

        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize                    = CGSizeMake(162*self.view.scale, 156 * self.view.scale);
        _collectionView                    = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate           = self;
        _collectionView.dataSource         = self;
        [_collectionView registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionCell class])];
        _collectionView.backgroundColor = [UIColor BackGroundColor];
    }
    return _collectionView;
}
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame     = CGRectMake(0, 0, 20, 15);
        _backItem        = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}
@end
