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
    [self.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#279F2A"]];
    self.navigationBar.translucent = NO;
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
}
@end
