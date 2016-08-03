//
//  SEMNavigationController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "SEMNavigationController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <UIViewController+MMDrawerController.h>
#import "SEMInitialViewController.h"
#import "YYCategories.h"
@interface SEMNavigationController () <UINavigationControllerDelegate>
@property (nonatomic,strong)UIBarButtonItem *backBarButtonItem;
@end

@implementation SEMNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:62/255.0 green:182/255.0 blue:103/255.0 alpha:0]];
    self.navigationBar.translucent = NO;
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.delegate = self;
}
- (void)selfPopView{
    
    [self popViewControllerAnimated: YES];
}




@end
