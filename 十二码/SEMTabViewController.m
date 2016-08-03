//
//  SEMTabViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTabViewController.h"
#import "HRTRouter.h"
#import "SEMHomeVIewController.h"
#import "SEMTeamViewController.h"
@interface SEMTabViewController ()
@property (nonatomic,strong)SEMHomeVIewController* fisrt;
@property (nonatomic,strong)SEMTeamViewController* sec;
@end

@implementation SEMTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = [NSArray arrayWithObjects:[HRTRouter objectForURL: @"Home?navigation=navigation"],[HRTRouter objectForURL: @"News?navigation=navigation"],[HRTRouter objectForURL: @"Game?navigation=navigation"],[HRTRouter objectForURL: @"Team?navigation=navigation"], nil];
    //self.viewControllers = [NSArray arrayWithObjects:self.fisrt,self.sec ,nil];
    
    
}
- (SEMHomeVIewController*)fisrt
{
    if (!_fisrt) {
        _fisrt = [[SEMHomeVIewController alloc] init];;
        UIImage* image = [[UIImage imageNamed:@"首页icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* selectedImage = [[UIImage imageNamed:@"首页icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _fisrt.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:selectedImage];
        [_fisrt.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [_fisrt.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    return _fisrt;
}

- (SEMTeamViewController*)sec
{
    if (!_sec) {
        _sec = [[SEMTeamViewController alloc] init];
        UIImage* image = [[UIImage imageNamed:@"球队icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* selectedImage = [[UIImage imageNamed:@"球队icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _fisrt.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"球队" image:image selectedImage:selectedImage];
        [_fisrt.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [_fisrt.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    return _sec;
}
@end
