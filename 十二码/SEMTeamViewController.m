//
//  SEMTeamViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTeamViewController.h"
#import "SEMTeamViewModel.h"
#import "NoticeCellView.h"
#import "ShareView.h"
@interface SEMTeamViewController ()<ShareViewDelegate>
@property (nonatomic,strong)SEMTeamViewModel* viewModel;
@end

@implementation SEMTeamViewController

#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NoticeCellView* view = [[NoticeCellView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, 156)];
    view.titleLabel.text = @"华中大杯";
    view.backgroundColor = [UIColor whiteColor];
    view.homeImageview.image = [UIImage imageNamed:@"zhanwei.jpg"];
    view.awayImgaeview.image = [UIImage imageNamed:@"zhanwei.jpg"];
    view.roundLabel.text = @"A组第一轮";
    view.awayTitleLabel.text = @"武汉大学";
    view.homeTitleLabel.text = @"华中二科技大学";
    view.homeScoreLabel.text = @"2";
    view.awaySocreLabel.text = @"1";
    view.status = 3;
    view.timeLabel.text = @"23:23:23";
    view.homeLabel.text = @"华中科技大学";
    view.location = 2;
    ShareView *tView = [[ShareView alloc] initWithFrame:CGRectZero];
    tView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    [self.view addSubview:tView];
    tView.delegate = self;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"移动" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 200, 100, 20);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CALayer* imageLayer = tView.layer;
        CGPoint fromPoint = imageLayer.position;
        CGPoint toPoint = CGPointMake(fromPoint.x , fromPoint.y - 200);
        // 创建不断改变CALayer的position属性的属性动画
        CABasicAnimation* anim = [CABasicAnimation
                                  animationWithKeyPath:@"position"];
        // 设置动画开始的属性值
        anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
        // 设置动画结束的属性值
        anim.toValue = [NSValue valueWithCGPoint:toPoint];
        anim.duration = 0.5;
        imageLayer.position = toPoint;
        anim.removedOnCompletion = YES;
        // 为imageLayer添加动画
        [imageLayer addAnimation:anim forKey:nil];
    }];
    // Do any additional setup after loading the view.
}
- (void)didSelectedShareView:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
}

- (void)addSubviews
{
    
}

- (void)makeConstraits
{
    
}
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"球队icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"球队icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"球队" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)bindModel
{
    self.title = self.viewModel.title;
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMTeamViewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark -initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTab];
    }
    return self;
}

@end
