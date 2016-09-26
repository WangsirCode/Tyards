//
//  PictureShowController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PictureShowController.h"
#import "MDABizManager.h"
#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)
@interface PictureShowController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) NSArray<UIImageView*>* imageArray;
@property (nonatomic,strong) UIScrollView* srcollView;
@end
@implementation PictureShowController
- (instancetype)initWithImages:(NSArray<NSString *> *)imagesURL index:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.ImageURLs = imagesURL;
        self.index = index;
    }
    return self;
}
#pragma mark- lifeCycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpview];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark- viewSetUp
- (void)setUpview
{
    self.view.backgroundColor = [UIColor blackColor];
    [self addSubviews];
    [self makeConstraits];
    //定位到当前的图片
    [self.srcollView setContentOffset:CGPointMake(self.index*self.view.width, 0) animated:NO];
}
- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.srcollView];
    [self.imageArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(0, 150*self.view.scale, self.view.width, 300*self.view.scale);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self saveImageToPhotosAlbum:obj.image];
        }];
        [alert addAction:cancelAction];
        [alert addAction:archiveAction];
        
        UILongPressGestureRecognizer* longgesture = [[UILongPressGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            //为什么不要这句就会报错
            if (self.presentedViewController == nil)
            {
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        [obj addGestureRecognizer:longgesture];
        UIScrollView* view = [[UIScrollView alloc] init];
//        view.frame = CGRectMake(idx*(self.view.width), 150*self.view.scale, self.view.width, 300*self.view.scale);
        view.frame = CGRectMake(idx*(self.view.width), 0, self.view.width, self.view.height);
        [view addSubview:obj];
        view.minimumZoomScale = 0.2;
        view.maximumZoomScale = 2;
        view.showsVerticalScrollIndicator = NO;
        view.showsHorizontalScrollIndicator = NO;
        view.delegate = self;
        [self.srcollView addSubview:view];
    }];
}
- (void)makeConstraits
{
    [self.srcollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)saveImageToPhotosAlbum:(UIImage*)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error != NULL){
        [XHToast showCenterWithText:@"保存失败"];
        
    }else{
       [XHToast showCenterWithText:@"保存成功"];
    }
}
#pragma mark - scrollviewdelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
   return  [scrollView.subviews objectAtIndex:0];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 105) {
        CGFloat offset = scrollView.contentOffset.x;
        self.index = offset / self.view.width;
    }
}
#pragma mark - getter
- (UIScrollView*)srcollView
{
    if (!_srcollView) {
        _srcollView = [UIScrollView new];
        _srcollView.delegate = self;
        _srcollView.pagingEnabled = YES;
        _srcollView.contentSize = CGSizeMake(self.ImageURLs.count*self.view.width, self.view.height);
        _srcollView.alwaysBounceVertical = NO;
        _srcollView.showsVerticalScrollIndicator = NO;
        _srcollView.userInteractionEnabled = YES;
        _srcollView.tag = 105;
    }
    return _srcollView;
}
- (NSArray<UIImageView *> *)imageArray
{
    if (!_imageArray) {
        NSMutableArray* array = [NSMutableArray new];
        [self.ImageURLs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView* view = [UIImageView new];
            if(obj)
            {
                NSURL* URL = [[NSURL alloc] initWithString:obj];
                [view sd_setImageWithURL:URL placeholderImage:[UIImage placeholderImage]];
            }
            view.clipsToBounds = YES;
            view.userInteractionEnabled = YES;
            view.contentMode = UIViewContentModeScaleAspectFit;
            [array addObject:view];
        }];
        _imageArray = array;
    }
    return _imageArray;
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
@end
