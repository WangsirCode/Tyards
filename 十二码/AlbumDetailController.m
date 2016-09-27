//
//  AlbumDetailController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "AlbumDetailController.h"
#import "MDABizManager.h"
#import "AlbumDetailViewModel.h"
#import "PhotoDetailCell.h"
#import "HZPhotoBrowser.h"
#import "PictureShowController.h"
@interface AlbumDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HZPhotoBrowserDelegate>
@property (nonatomic,strong) AlbumDetailViewModel *viewModel;
@property (nonatomic,strong) UICollectionView     *collectionView;
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) HZPhotoBrowser       *browser;
@end
@implementation AlbumDetailController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[AlbumDetailViewModel alloc] initWithDictionary:dictionary];
    }
    return self;
}
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
    self.view.backgroundColor = [UIColor BackGroundColor];
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
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(8, 0, 0, 0));
    }];
}
- (void)bindModel
{
    self.navigationItem.title = self.viewModel.title;
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
    return self.viewModel.model.medias.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    Medias* model = self.viewModel.model.medias[indexPath.row];
    PhotoDetailCell* cell = (PhotoDetailCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"detailcell" forIndexPath:indexPath];
    cell.model = model.media;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12*self.view.scale, 12*self.view.scale, 0, 6*self.view.scale);
}

#pragma mark-collectionviewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableArray* array = [NSMutableArray new];
//    [self.viewModel.model.medias enumerateObjectsUsingBlock:^(Medias * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [array addObject:obj.media.url];
//    }];
    self.browser.currentImageIndex = (int)indexPath.row;
    // 展示图片浏览器
    [self.browser show];
//    PictureShowController* controller = [[PictureShowController alloc] initWithImages:array index:indexPath.row];
//    [self.navigationController pushViewController:controller animated:YES];
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    PhotoDetailCell* cell = (PhotoDetailCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.imageView.image;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL* url = [[NSURL alloc] initWithString:self.viewModel.model.medias[index].media.url];
    return url;
}
#pragma mark- getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize                    = CGSizeMake(110*self.view.scale, 108*self.view.scale);
        _collectionView                    = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate           = self;
        _collectionView.dataSource         = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[PhotoDetailCell class] forCellWithReuseIdentifier:@"detailcell"];
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
        _hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    }
    return _hud;
}
- (HZPhotoBrowser *)browser
{
    if (!_browser) {
        _browser = [[HZPhotoBrowser alloc] init];
        _browser.sourceImagesContainerView = self.collectionView;
        _browser.imageCount = self.viewModel.medias.count;
        _browser.delegate = self;
    }
    return _browser;
}
@end
