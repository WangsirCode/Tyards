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
@property (nonatomic,strong) UIImageView* imageView;
@end
@implementation PictureShowController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = self.backItem;
    _srcollView = [[UIScrollView alloc]init];
    _srcollView.delegate = self;
    
    _srcollView.userInteractionEnabled = YES;
    _srcollView.showsHorizontalScrollIndicator = YES;//是否显示侧边的滚动栏
    _srcollView.showsVerticalScrollIndicator = NO;
    _srcollView.scrollsToTop = NO;
    _srcollView.scrollEnabled = YES;
    _srcollView.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
    UIImage *img = [UIImage imageNamed:@"Group 19"];
    _imageView = [[UIImageView alloc]initWithImage:img];
    //设置这个_imageView能被缩放的最大尺寸，这句话很重要，一定不能少,如果没有这句话，图片不能缩放
    _imageView.frame = CGRectMake(0, 200, MRScreenWidth, MRScreenHeight / 3);
    [self.view addSubview:_srcollView];
    [_srcollView addSubview:_imageView];


    [_srcollView setMinimumZoomScale:0.25f];
    [_srcollView setMaximumZoomScale:3.0f];
    [_srcollView setZoomScale:0.5f animated:NO];
//    self.imageView = [[UIImageView alloc] initWithImage:self.image];
////    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.imageView.clipsToBounds = YES;
//    [self.view addSubview:self.imageView];
//    self.imageView.sd_layout
//    .centerYEqualToView(self.view)
//    .centerXEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .heightIs(300*self.view.scale);
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = _srcollView.frame.size.height / scale;
    NSLog(@"zoomRect.size.height is %f",zoomRect.size.height);
    NSLog(@"self.frame.size.height is %f",_srcollView.frame.size.height);
    zoomRect.size.width  = _srcollView.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
//当滑动结束时
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",scale);
    [_srcollView setZoomScale:scale animated:NO];
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
