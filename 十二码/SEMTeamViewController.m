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
#import "GameListView.h"
@interface SEMTeamViewController ()
@property (nonatomic,strong)SEMTeamViewModel* viewModel;
@end

@implementation SEMTeamViewController

#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    GameListView *view = [[GameListView alloc] init];

    view.titleLabel.text = @"华中大足球金表嫂";
    view.logoImageView.image = [UIImage imageNamed:@"logo"];
    view.timeLabel.text = @"2013-32-45 19L32:32";
    view.status = 1;
    view.location = @"华中赛区";
    view.frame = CGRectMake(0, 100, 375, 100);
    [self.view addSubview:view];
    // Do any additional setup after loading the view.
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
